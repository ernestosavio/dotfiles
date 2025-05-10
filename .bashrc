#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Variables personales
export MOZ_ENABLE_WAYLAND=1

# y() function for Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Alias para el git bare de .config
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# Highlight man
export GROFF_NO_SGR=0
export MANROFFOPT="-c"
export LESS="--RAW-CONTROL-CHARS"
export MANPAGER="less -R"
# export MANPAGER="less -R --use-color -Dd+r -Du+b"

export LESS_TERMCAP_md=$'\e[1;36m'  # Cian brillante para negrita
export LESS_TERMCAP_me=$'\e[0m'     # Reset
export LESS_TERMCAP_so=$'\e[1;33;44m'  # Fondo azul con texto amarillo para search highlight
export LESS_TERMCAP_se=$'\e[0m'     # Reset
export LESS_TERMCAP_us=$'\e[1;32m'  # Verde brillante para subrayado
export LESS_TERMCAP_ue=$'\e[0m'     # Reset

[ -f "/home/ernesto/.ghcup/env" ] && . "/home/ernesto/.ghcup/env" # ghcup-env