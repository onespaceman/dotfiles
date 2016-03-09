# ~/.zshrc

#zplug
source "$HOME/.zplug/zplug"

zplug "b4b4r07/zplug"
zplug "zsh-users/zsh-syntax-highlighting", nice:10
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "plugins/git", from:oh-my-zsh
zplug "onespaceman/af3ef877e4a0e8c8a762", from:gist, of:minimal-theme
zplug "sorin-ionescu/prezto", of:"modules/{spectrum,terminal,history}/init.zsh"
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:terminal' auto-title 'yes'

zplug check || zplug install && zplug load

#environment
#export set PATH=$PATH:$HOME/bin
source $HOME/.aliases

#default editor
export EDITOR=“nvim”
export VISUAL="nvim"

#allow special characters without quotes
setopt EXTENDED_GLOB

#case insensitive globbing
setopt NO_CASE_GLOB

#virtualenvs
export WORKON_HOME=$HOME/.virtualenvs
source "/usr/bin/virtualenvwrapper.sh"

