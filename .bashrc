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
export EDITOR=nvim

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

# Java necesita que las apps esten encerradas por un marco y algunos twm
# no los ponen y hace que la aplicacion se quede en blanco, poniento esto
# anda bien
export _JAVA_AWT_WM_NONREPARENTING=1

#Alias para la compuvieja
alias compuvieja='pcvieja@192.168.0.100' # Red 2.4 termina en .110 
                                         # Red 5.0 termina en .100 (default)
                                        
# Función súper ligera para obtener el estado de Git
parse_git_status() {
    # Obtener el nombre de la rama actual ocultando errores si no es un repo
    local branch
    branch=$(git branch --show-current 2>/dev/null)
    
    # Si estamos dentro de un repositorio de Git
    if [ -n "$branch" ]; then
        local dirty=""
        # Revisar si hay cambios sin comitear de forma rápida (--porcelain)
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            dirty="*" # Asterisco si hay cambios
        fi
        # Imprimir la rama con un color sutil
        echo -e " \033[35m($branch$dirty)\033[00m"
    fi
}

# Configuración del prompt (PS1) minimalista
# \[\033[36m\] -> Color Cyan
# \W           -> Solo el nombre de la carpeta actual (ej: "nachos" en vez de "/home/.../nachos")
# \[\033[00m\] -> Resetear color
# \$           -> Muestra $ para usuario normal, # para root
export PS1='\[\033[36m\]\w\[\033[00m\]$(parse_git_status) \$ '
                                         
