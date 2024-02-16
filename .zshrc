# Plugin manager
source $HOME/.zsh/zinit/zinit.zsh \
    || (git clone --depth 1 https://github.com/zdharma-continuum/zinit.git $HOME/.zsh/zinit && exec zsh)

# Theme
zinit ice depth=1 atload="source $HOME/.p10k.zsh"
zinit light romkatv/powerlevel10k

# Plugin list
zinit lucid light-mode depth=1 nocd for \
    atload='_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
    atload='MODE_CURSOR_VIINS="bar"; vim-mode-cursor-init-hook' softmoth/zsh-vim-mode \
    hlissner/zsh-autopair \
    zsh-users/zsh-completions \
    zdharma-continuum/fast-syntax-highlighting
zinit lucid is-snippet for \
    https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh \
    https://github.com/ajeetdsouza/zoxide/blob/main/zoxide.plugin.zsh
    

# Options
setopt \
    autocd \
    autopushd \
    histignorealldups \
    histignorespace \
    sharehistory

# Disable right prompt indent
ZLE_RPROMPT_INDENT=0

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Key bindings
export KEYTIMEOUT=1

# Aliases
source $HOME/.aliases

# General functions
source $HOME/.functions

# Private functions/scripts
source $HOME/Axon/sources/private-scripts/.functions
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
