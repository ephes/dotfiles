# Set up the prompt

autoload -Uz promptinit
promptinit
prompt off

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
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

# paths
export PATH=${HOME}/miniconda3/bin:$PATH

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
    source /usr/local/bin/virtualenvwrapper.sh
    export WORKON_HOME=~/.virtualenvs
else
    # machine runs Linux

    # aliases
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    # virtualenv
    source ~/.local/bin/virtualenvwrapper.sh
    export WORKON_HOME=~/.virtualenvs
fi
