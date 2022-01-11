# pip install --user
fish_add_path /Users/jochen/.local/bin

# fzf
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_DEFAULT_OPTS "--layout=reverse --inline-info"

# aliases
alias fvim "vim (fzf)"
alias pcy "python commands.py"

alias l='exa'
alias la='exa -a'
alias ll='exa -lah'
alias ls='exa --color=auto'
