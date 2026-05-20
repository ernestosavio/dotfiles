#!/bin/bash
# Sobreescribe el archivo con la lista actual de servicios habilitados
systemctl list-unit-files --state=enabled > ~/.systemd-enabled.txt
