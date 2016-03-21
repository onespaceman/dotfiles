# zsh syntax highlighting

if [ "$(uname)" = "Linux" ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ "$(uname)" = "Darwin" ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
