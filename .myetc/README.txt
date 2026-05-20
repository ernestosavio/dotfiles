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
