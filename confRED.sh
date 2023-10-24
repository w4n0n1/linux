#!/bin/bash

# Instalar net-tools
sudo apt install net-tools

# Cambiar al directorio /etc/netplan
cd /etc/netplan

# Abrir el archivo de configuración 00-installer-config.yaml con nano
sudo nano 00-installer-config.yaml

# Editar el archivo 00-installer-config.yaml para configurar la red
# Asegúrate de reemplazar "[dirección IP/24]", "[dirección IP]" y "[dirección IP]" con los valores adecuados.
cat <<EOL | sudo tee 00-installer-config.yaml > /dev/null
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:   # Reemplaza con tu interfaz de red
      dhcp4: false
      addresses: [dirección IP/24]
      gateway4: [dirección IP]
      nameservers:
        addresses: [dirección IP]
EOL

# Aplicar la configuración de netplan
sudo netplan apply
