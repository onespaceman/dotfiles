# ~/.zshrc

#source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export set PATH=$PATH:$HOME/scripts
export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz

source $HOME/.aliases

# cd to dir with just the dir
setopt AUTO_CD

#default editor
export EDITOR=“nvim”
export VISUAL="nvim"

# allow special characters without quotes
setopt EXTENDED_GLOB

# Case insensitive globbing
setopt NO_CASE_GLOB

#virtualenvs
export WORKON_HOME=$HOME/.virtualenvs
source "/usr/bin/virtualenvwrapper.sh"

