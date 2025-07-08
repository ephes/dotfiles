#!/usr/bin/env fish

function ta
    # Check if host argument is provided
    if test (count $argv) -eq 0
        echo "Usage: remote-tmux <user@host|ssh-alias>"
        echo "Example: remote-tmux user@example.com"
        echo "Example: remote-tmux myserver"
        return 1
    end

    set -l remote_host $argv[1]

    # Check if fzf is installed
    if not command -v fzf >/dev/null
        echo "Error: fzf is not installed. Please install it first."
        echo "  brew install fzf  # macOS"
        echo "  sudo apt install fzf  # Ubuntu/Debian"
        return 1
    end

    # Check SSH connection and tmux availability
    echo "Checking connection to $remote_host..."
    if not ssh -o ConnectTimeout=5 -o BatchMode=yes $remote_host "command -v tmux" >/dev/null 2>&1
        echo "Error: Cannot connect to $remote_host or tmux is not installed"
        return 1
    end

    # Get list of tmux sessions
    set -l sessions (ssh -A $remote_host "tmux list-sessions 2>/dev/null" | string collect)
    
    if test -z "$sessions"
        echo "No tmux sessions found on $remote_host"
        read -P "Create a new session? [Y/n] " -n 1 create_new
        echo
        
        if test "$create_new" != "n" -a "$create_new" != "N"
            read -P "Session name (leave empty for default): " session_name
            if test -n "$session_name"
                ssh -A -t $remote_host "tmux new-session -s '$session_name'"
            else
                ssh -A -t $remote_host "tmux new-session"
            end
        end
        return
    end

    # Parse sessions and prepare for fzf
    set -l session_list
    for session in (string split \n $sessions)
        # Extract session name (before the first colon)
        set -l session_name (string split -m 1 ':' $session | head -1)
        # Get the rest of the info
        set -l session_info (string replace -r '^[^:]+: ' '' $session)
        set session_list $session_list "$session_name: $session_info"
    end

    # Use fzf to select a session
    set -l selected (printf '%s\n' $session_list | \
        fzf --height=50% \
            --header="Select tmux session on $remote_host" \
            --preview="echo 'Session details:'; echo '{}' | sed 's/: /\n  /g'" \
            --preview-window=right:40% \
            --bind='ctrl-n:execute(echo NEW_SESSION)+abort' \
            --header-lines=0)

    # Handle fzf exit/cancellation
    if test -z "$selected"
        if test "$selected" = "NEW_SESSION"
            read -P "New session name: " new_session_name
            if test -n "$new_session_name"
                ssh -A -t $remote_host "tmux new-session -s '$new_session_name'"
            else
                ssh -A -t $remote_host "tmux new-session"
            end
        else
            echo "No session selected"
        end
        return
    end

    # Extract session name from selection
    set -l session_name (string split -m 1 ':' $selected | head -1)

    # Connect to the selected session
    echo "Connecting to session: $session_name"
    echo ""
    echo "Note: To fix SSH agent forwarding in existing shells, the remote server"
    echo "needs the refresh_tmux_vars function. See: remote-tmux-setup"
    echo ""
    
    ssh -A -t $remote_host "tmux attach-session -t '$session_name'"
end

# Create alias for convenience
alias rtmux='remote-tmux'

# Function to set up the remote server for proper SSH agent forwarding
function remote-tmux-setup
    echo "To enable automatic SSH agent forwarding in tmux on the remote server,"
    echo "add this function to ~/.config/fish/functions/refresh_tmux_vars.fish:"
    echo ""
    echo '# Auto-refresh tmux environment variables on every command'
    echo 'function refresh_tmux_vars --on-event="fish_preexec"'
    echo '    if set -q TMUX'
    echo '        tmux showenv -s | string replace -rf \'^((?:SSH|DISPLAY).*?)=(".*?"); export.*\' \'set -gx $1 $2\' | source'
    echo '    end'
    echo 'end'
    echo ""
    echo "For bash/zsh users, add to ~/.bashrc or ~/.zshrc:"
    echo ""
    echo 'function refresh_tmux_vars {'
    echo '    if [ -n "$TMUX" ]; then'
    echo '        eval $(tmux showenv -s | grep -E "^(SSH|DISPLAY)")'
    echo '    fi'
    echo '}'
    echo ''
    echo '# For zsh:'
    echo 'function preexec {'
    echo '    refresh_tmux_vars'
    echo '}'
    echo ''
    echo '# For bash (needs bash-preexec):'
    echo 'preexec() { refresh_tmux_vars; }'
    echo ""
    echo "You can also manually refresh in any shell by running:"
    echo "  fish: tmux showenv -s | string replace -rf '^((?:SSH|DISPLAY).*?)=(\".*?\"); export.*' 'set -gx \$1 \$2' | source"
    echo "  bash: eval \$(tmux showenv -s | grep -E '^(SSH|DISPLAY)')"
end

# Add help function
function remote-tmux-help
    echo "remote-tmux - Connect to remote tmux sessions with fzf selection"
    echo ""
    echo "Usage:"
    echo "  remote-tmux <user@host|ssh-alias>"
    echo "  rtmux <user@host|ssh-alias>  # short alias"
    echo ""
    echo "Features:"
    echo "  - Lists all tmux sessions on remote host"
    echo "  - Interactive selection with fzf"
    echo "  - SSH agent forwarding enabled (-A flag)"
    echo "  - Create new session if none exist"
    echo "  - Press Ctrl-N in fzf to create new session"
    echo ""
    echo "SSH Agent Forwarding:"
    echo "  For proper SSH agent forwarding in existing tmux sessions,"
    echo "  run 'remote-tmux-setup' to see the required server configuration."
    echo ""
    echo "Requirements:"
    echo "  - fzf installed locally"
    echo "  - tmux installed on remote host"
    echo "  - SSH access to remote host"
    echo ""
    echo "Examples:"
    echo "  remote-tmux user@example.com"
    echo "  remote-tmux production-server  # using SSH config alias"
    echo "  rtmux dev-box"
end
