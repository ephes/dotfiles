# ta.fish — "tmux attach" helper for Fish shell with remote fzf session picker
#
# Usage:
#   ta <remote-host>
#
# Description:
#   Connects to a remote host via SSH and lists available tmux sessions.
#   If any sessions exist, shows a fuzzy finder (fzf) menu to pick one.
#   If no session exists, it creates a new one.
#   Automatically attaches to the selected session using `ssh -t`.
#
# Requirements:
#   - fzf must be installed locally
#   - tmux must be installed on the remote host
#   - SSH key-based access recommended for convenience

function ta
    if test (count $argv) -ne 1
        echo "Usage: ta <remote-host>"
        return 1
    end

    set host $argv[1]
    set sessions (ssh -A $host "tmux list-sessions -F '#S' 2>/dev/null")

    if test -z "$sessions"
        ssh -t $host "tmux new-session"
    else
        set choice (printf "%s\n" $sessions | fzf --prompt="TMUX on $host> ")

        if test -z "$choice"
            echo "No session selected."
            return 1
        end

        ssh -t $host "tmux attach-session -t $choice"
    end
end
