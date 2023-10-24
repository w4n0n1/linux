#!/bin/bash

# Actualizar el sistema
sudo apt update
sudo apt upgrade -y

# Instalar Apache2
sudo apt install -y apache2

# Instalar MySQL Server
sudo apt install -y mysql-server

# Acceder a MySQL y ejecutar comandos
sudo mysql <<EOF
CREATE DATABASE ciber_db;
CREATE USER 'ciber1'@'%' IDENTIFIED WITH mysql_native_password BY 'Passw0rd2023';
GRANT ALL ON ciber_db.* TO 'ciber1'@'%';
exit
EOF

# Instalar PHP y módulos relacionados
sudo apt install -y php libapache2-mod-php php-mysql

# Verificar la versión de PHP
php -v

# Crear un directorio para el sitio web
sudo mkdir /var/www/nombredominio

# Cambiar la propiedad del directorio al usuario actual
sudo chown -R $USER:$USER /var/www/nombredominio

# Crear un archivo de configuración del sitio
sudo tee /etc/apache2/sites-available/nombredominio.conf > /dev/null <<EOL
<VirtualHost *:80>
    ServerName nombredominio
    ServerAlias www.nombredominio.ciber
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/nombredominio
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOL

# Habilitar el sitio
sudo a2ensite nombredominio

# Deshabilitar el sitio predeterminado
sudo a2dissite 000-default

# Verificar la configuración de Apache
sudo apache2ctl configtest

# Recargar la configuración de Apache
sudo systemctl reload apache2

# Crear un archivo index.html en el directorio del sitio web
sudo tee /var/www/nombredominio/index.html > /dev/null <<EOL
<h1>Página funcionando</h1>
EOL

# Configurar la prioridad de index en Apache
sudo nano /etc/apache2/mods-enabled/dir.conf

# Recargar la configuración de Apache
sudo systemctl reload apache2

# Crear un archivo info.php en el directorio del sitio web
sudo tee /var/www/nombredominio/info.php > /dev/null <<EOL
<?php
phpinfo();
EOL

# Eliminar el archivo info.php si se necesita
# sudo rm /var/www/nombredominio/info.php
