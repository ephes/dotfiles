# Created by `userpath` on 2019-11-27 06:20:04
set PATH $PATH /Users/jochen/.local/bin

# pipx completions
# register-python-argcomplete --shell fish pipx | .
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths

# header files for gcc from apple command line tools
set -x CPATH $CPATH (xcrun --show-sdk-path)/usr/include

# enable compiling against homebrew openssl
set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"
set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig"

# on pwd change look for env file and load it
function load_env --on-variable PWD
  if test -e .env
    export (grep -Ev '^\s*$|^\s*\#' .env)
  end
end

# on pwd change look for conda environment.yml and activate conda env
function activate_conda_env --on-variable PWD
  if test -e environment.yml
    pyenv activate (pyenv virtualenvs | grep miniconda | cut -d " " -f 3)
    conda activate (grep name environment.yml | cut -d " " -f 2)
  end
end

# autocompletion is slow in catalina
function __fish_describe_command; end

# iTerm2 shell integration
source ~/.iterm2_shell_integration.(basename $SHELL)

# pyenv / pyenv-virtualenv
set -gx PYENV_ROOT $HOME/.pyenv
set -gx PATH $PYENV_ROOT/bin $PATH
status --is-interactive; and source (pyenv init -|psub)
# status --is-interactive; and source (pyenv virtualenv-init -|psub)

# enable framework for python via pyenv needed for you complete me
set -gx PYTHON_CONFIGURE_OPTS "--enable-framework"

# git autocompletion issues https://github.com/pyenv/pyenv/issues/688
# needs to be afte pyenv path modifications
set -gx PATH /usr/local/opt/gettext/bin $PATH

# fzf
set -gx FZF_DEFAULT_COMMAND "fd --type f"
set -gx FZF_DEFAULT_OPTS "--layout=reverse --inline-info"

# Use buildkit for docker-compose
set -gx COMPOSE_DOCKER_CLI_BUILD=1
set -gx DOCKER_BUILDKIT=1

# aliases
alias tests "poetry run test"
alias pytests "poetry run pytest"
alias dshell "poetry run shell"
alias lint "poetry run lint"
alias docs "poetry run docs"
alias show_coverage "poetry run show_coverage"
alias fvim "vim (fzf)"
