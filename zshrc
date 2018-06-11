# Set up the prompt

autoload -Uz promptinit
promptinit
prompt off

setopt histignorealldups nosharehistory

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# completion for directories
zstyle ':completion:*' special-dirs true

# paths
. ${HOME}/miniconda3/etc/profile.d/conda.sh

# make zsh escape backspace work like in bash (kill only to the next
# backslash, not the whole path)
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# aliases
alias sa='source activate'
alias sd='source deactivate'

# platform specific stuff
UNAME=$(uname)
if [ "$UNAME" = 'Darwin' ];
then
    # machine runs MacOS

    # aliases
    alias ls='ls -G'
    alias vim='/usr/local/bin/vim'

    # virtualenv
    VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    source /usr/local/bin/virtualenvwrapper.sh
    export WORKON_HOME=~/.virtualenvs

    # postgres start stop
    alias pg-start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
    alias pg-stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"

else
    # machine runs Linux

    # aliases
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    # virtualenv
    VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    source ~/.local/bin/virtualenvwrapper.sh
    export WORKON_HOME=~/.virtualenvs
fi

unsetopt share_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jochen/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/jochen/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jochen/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/jochen/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
