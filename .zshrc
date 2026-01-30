[[ $- != *i* ]] && return

export VISUAL="${EDITOR}"
export EDITOR='nvim'
export BROWSER='firefox'
export PATH="$HOME/.local/bin:$PATH"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd..)"
export SUDO_PROMPT="Passwd: "

autoload -Uz compinit
compinit

command -v fastfetch >/dev/null && fastfetch
