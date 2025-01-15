#!/bin/bash

# Obtener el PID de la ventana activa
pid=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.type=="con") | select(.focused==true).pid')
ppid=$(pgrep --newest --parent ${pid})
DIR=$(readlink /proc/${ppid}/cwd || echo $HOME)
ghostty --working-directory="$DIR"

