#!/bin/bash

# Instalar Bind9 y Bind9-utils
sudo apt install bind9 bind9-utils

# Verificar el estado de UFW
sudo ufw status

# Permitir el tráfico para Bind9
sudo ufw allow bind9

# Verificar el estado de Bind9
sudo systemctl status bind9

# Editar el archivo named.conf.options
sudo nano /etc/bind/named.conf.options

# Contenido del archivo named.conf.options
cat <<EOL | sudo tee /etc/bind/named.conf.options > /dev/null
options {
    directory "/var/cache/bind";
    // the all-0’s placeholder.
    listen-on { any; };
    allow-query { localhost; 192.168.0.0/24; };
    forwarders {
        8.8.8.8;
    };
    dnssec-validation no;
};
EOL

# Editar el archivo de configuración /etc/default/named
sudo nano /etc/default/named

# Modificar OPTIONS en /etc/default/named
# Agregar " -u bind -4" al final
OPTIONS="-u bind -4"

# Verificar la configuración de Bind9
sudo named-checkconf

# Reiniciar el servicio Bind9
sudo systemctl restart bind9

# Verificar el estado de Bind9
sudo systemctl status bind9

# Editar el archivo named.conf.local
sudo nano /etc/bind/named.conf.local

# Contenido del archivo named.conf.local
cat <<EOL | sudo tee /etc/bind/named.conf.local > /dev/null
zone "ciber.local" IN {
    type master;
    file "/etc/bind/zonas/db.ciber.local";
};
zone "0.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zonas/db.0.168.192";
};
EOL

# Crear el directorio /etc/bind/zonas
sudo mkdir /etc/bind/zonas

# Copiar db.local a db.ciber.local
sudo cp /etc/bind/db.local /etc/bind/zonas/db.ciber.local

# Editar el archivo db.ciber.local
sudo nano /etc/bind/zonas/db.ciber.local

# (Agrega o edita las entradas DNS para tu zona)

# Copiar db.local a db.0.168.192
sudo cp /etc/bind/db.local /etc/bind/zonas/db.0.168.192

# Editar el archivo db.0.168.192
sudo nano /etc/bind/zonas/db.0.168.192

# (Agrega o edita las entradas DNS inversas)

# Verificar la configuración de named.conf.local
sudo named-checkconf /etc/bind/named.conf.local

# Verificar la zona ciber.local
sudo named-checkzone ciber.local /etc/bind/zonas/db.ciber.local

# Verificar la zona inversa
sudo named-checkzone 0.168.192.in-addr.arpa /etc/bind/zonas/db.0.168.192

# Reiniciar el servicio Bind9
sudo systemctl restart bind9

# Verificar el estado de Bind9
sudo systemctl status bind9

# Editar el archivo /etc/resolv.conf
sudo nano /etc/resolv.conf

# (Agrega tus servidores DNS)

# Hacer una copia de seguridad del archivo resolv.conf
sudo cp /etc/resolv.conf /etc/resolv.conf.bk

# Eliminar el archivo resolv.conf
sudo rm /etc/resolv.conf

# Hacer que el archivo de respaldo sea inmutable
sudo chattr +i /etc/resolv.conf.bk

# Restaurar el archivo resolv.conf desde la copia de seguridad
sudo cp /etc/resolv.conf.bk /etc/resolv.conf
