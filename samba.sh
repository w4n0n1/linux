#!/bin/bash

# Verificar el estado de smbd
sudo systemctl status smbd

# Crear la estructura de directorios
sudo mkdir /samba
cd /samba
sudo mkdir public
sudo chown -R nobody:nogroup public
sudo chmod -R 0777 public

# Configurar el usuario de Samba
sudo chgrp sambashare public
sudo smbpasswd -a ciber
## Ingrese nueva contraseña
sudo smbpasswd -e ciber

# Editar smb.conf
sudo tee -a /etc/samba/smb.conf > /dev/null <<EOL
[public]
path = /samba/public
guest ok = no
writeable = yes
write list = ciber
browseable = yes
create mask = 0777
directory mask = 0777
EOL

# Reiniciar el servicio Samba
sudo systemctl restart smbd

# Configurar el firewall para permitir Samba
sudo ufw status
sudo ufw allow samba
sudo ufw status
sudo ufw status verbose
