# Include custom scripts in $PATH
export PATH="$PATH:/opt/local/bin:$HOME/.local/bin"

# Input method
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# Vim
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'

# Fix Java application renders as a plain gray box
export _JAVA_AWT_WM_NONREPARENTING=1

# Hide emojis
export PIPENV_HIDE_EMOJIS=1
export MINIKUBE_IN_STYLE=0

# nnn
export NNN_PLUG='f:fzcd;n:bulknew;z:autojump'

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --strip-cwd-prefix'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# workaround for: https://stackoverflow.com/questions/70333903/error-could-not-build-wheels-for-pymssql-which-is-required-to-install-pyprojec
export LDFLAGS="-L/opt/homebrew/opt/freetds/lib -L/opt/homebrew/opt/openssl@3/lib"
export CFLAGS="-I/opt/homebrew/opt/freetds/include"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
