function refresh_tmux_vars --on-event fish_preexec
    if set -q TMUX
        # Parse tmux showenv output and set variables
        tmux showenv -s | while read -l line
            # Match lines like: SSH_AUTH_SOCK="/tmp/ssh-xxx/agent.xxx"; export SSH_AUTH_SOCK;
            if string match -qr '^(SSH_AUTH_SOCK|DISPLAY)=(.+); export' -- $line
                # Extract variable name and value
                set -l var (string match -r '^([^=]+)' -- $line)[2]
                set -l val (string match -r '="([^"]+)"' -- $line)[2]
                
                # Set the variable if we found both
                if test -n "$var" -a -n "$val"
                    set -gx $var $val
                end
            end
        end
    end
end
