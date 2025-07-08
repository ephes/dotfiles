#!/usr/bin/env fish

# ta - "tmux attach" - Connect to remote tmux sessions with SSH agent forwarding
#
# This function provides an interactive way to connect to tmux sessions on remote hosts
# with proper SSH agent forwarding support. It uses fzf for session selection.
#
# How it works:
# 1. Takes a remote host as argument (can be user@host or an SSH config alias)
# 2. Connects via SSH to list available tmux sessions
# 3. Presents sessions in an interactive fzf menu with preview
# 4. Connects to the selected session with SSH agent forwarding (-A flag)
#
# SSH Agent Forwarding:
# - Uses 'ssh -A' to forward your local SSH agent to the remote host
# - This allows you to use your local SSH keys within the remote tmux session
# - Requires refresh_tmux_vars function on the remote host to update SSH_AUTH_SOCK
#   in existing shells (new shells/panes will work automatically)
#
# Special features:
# - Ctrl-N in the session list to create a new session
# - Automatically offers to create a session if none exist
# - Shows session details (windows, creation time) in the preview pane
#
# Requirements:
# - fzf installed locally for the interactive selection
# - tmux installed on the remote host
# - SSH access to the remote host
# - (Optional) refresh_tmux_vars function on remote for existing shells
#
# Usage:
#   ta myserver          # Connect using SSH config alias
#   ta user@host.com     # Connect using full hostname
#
function ta
    # Check if host argument is provided
    if test (count $argv) -eq 0
        echo "Usage: ta <user@host|ssh-alias>"
        echo "Example: ta user@example.com"
        echo "Example: ta myserver"
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
    
    # Use fzf to select a session
    # Pass the raw session list to fzf, let it parse naturally
    set -l selected (echo "$sessions" | \
        fzf --height=50% \
            --header="Select tmux session on $remote_host (Ctrl-N for new)" \
            --preview='echo "Session info:"; echo {}' \
            --preview-window=right:50% \
            --bind='ctrl-n:execute(echo ":::NEW_SESSION:::")+abort')
    
    # Handle fzf exit/cancellation
    if test -z "$selected"
        echo "No session selected"
        return
    end
    
    # Check if user wants a new session
    if test "$selected" = ":::NEW_SESSION:::"
        read -P "New session name: " new_session_name
        if test -n "$new_session_name"
            ssh -A -t $remote_host "tmux new-session -s '$new_session_name'"
        else
            ssh -A -t $remote_host "tmux new-session"
        end
        return
    end
    
    # Extract session name from selection (everything before the first colon)
    set -l session_name (string split -m 1 ':' $selected | head -1)
    
    # Connect to the selected session
    echo "Connecting to session: $session_name"
    ssh -A -t $remote_host "tmux attach-session -t '$session_name'"
end
