#!/bin/bash

REPO_DIR="$HOME/.myetc"

echo "Limpiando el directorio de backup anterior..."
rm -rf "$REPO_DIR"

echo "Creando estructura de directorios..."
mkdir -p "$REPO_DIR/pacman.d"
mkdir -p "$REPO_DIR/udev/rules.d"
mkdir -p "$REPO_DIR/sysctl.d"
mkdir -p "$REPO_DIR/efi-loader"
mkdir -p "$REPO_DIR/boot-loader"

echo "Copiando pacman y makepkg..."
cp /etc/pacman.conf "$REPO_DIR/"
cp /etc/makepkg.conf "$REPO_DIR/"

# Usamos 2>/dev/null || true por si no tienes hooks creados, para que el script no frene con error
cp -r /etc/pacman.d/hooks "$REPO_DIR/pacman.d/" 2>/dev/null || true
cp /etc/pacman.d/mirrorlist "$REPO_DIR/pacman.d/"

echo "Copiando sysctl.d..."
# El "/." al final asegura que copie el contenido de sysctl.d directo en la carpeta de destino
cp -r /etc/sysctl.d/. "$REPO_DIR/sysctl.d/" 2>/dev/null || true

echo "Copiando reglas de udev (Kanata, brillo, etc)..."
cp /etc/udev/rules.d/*.rules "$REPO_DIR/udev/rules.d/" 2>/dev/null || true

echo "Copiando fstab como referencia..."
cp /etc/fstab "$REPO_DIR/fstab.reference"

echo "Copiando locale .gen y .conf..."
cp /etc/locale.gen "$REPO_DIR/"
cp /etc/locale.conf "$REPO_DIR/"
cp /etc/vconsole.conf "$REPO_DIR/"

# Copiamos loader.conf
sudo cp /efi/loader/loader.conf "$REPO_DIR/efi-loader/"

# Copiamos toda la carpeta de entradas (entries)
sudo cp -r /boot/loader/entries "$REPO_DIR/boot-loader/"

echo "Ajustando permisos..."
# Asegurar que tu usuario sea el dueño de todo lo copiado
sudo chown -R $USER:$USER "$REPO_DIR"

echo "Generando README.txt..."
cat << 'EOF' > "$REPO_DIR/README.txt"
============================================================
RESPALDO DE CONFIGURACIONES CRÍTICAS DEL SISTEMA (/etc y /efi)
============================================================

Este directorio contiene configuraciones esenciales del sistema que viven 
fuera del directorio de usuario ($HOME).

Pasos clave para la restauración en una instalación limpia:

1. GESTOR DE PAQUETES (pacman):
   - Reemplazar /etc/pacman.conf y /etc/makepkg.conf con estos archivos.
   - Copiar los hooks y la mirrorlist dentro de /etc/pacman.d/.

2. ENTORNO DE ENTRADA Y PERMISOS (udev):
   - Mover las reglas de udev a /etc/udev/rules.d/ para recuperar los 
     permisos de uinput (esencial para Kanata) y el control de brillo.

3. ARRANQUE (systemd-boot):
   - Copiar loader.conf y la carpeta entries/ a /efi/loader/.
   - IMPORTANTE: Verificar los UUIDs de los discos en los archivos .conf 
     de las entradas antes de reiniciar, ya que pueden variar.

4. AJUSTES DEL KERNEL (sysctl):
   - Copiar el contenido de sysctl.d/ a /etc/sysctl.d/ para restablecer
     las optimizaciones de descriptores de archivos y memoria.

5. DISCOS (fstab):
   - Usar fstab.reference únicamente como guía visual de los puntos de 
     montaje anteriores. No copiar directamente.

**IMPORTANTE**
Hay aplicaciones que instale directamente el binario. De las que recuerdo son:
- Docker y Docker compose
- Scilab
EOF

echo "Listo"
