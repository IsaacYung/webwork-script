#!/bin/bash

echo "Nome do vhost:"
read vhost_name
echo "IP:"
read ip_vhost

echo "  #Criando diretorio..."
mkdir /home/$USER/workspace/$vhost_name
mkdir /home/$USER/workspace/Logs/$vhost_name

echo "  #Criando $vhost_name.dev.conf..."
echo "
  <VirtualHost *:80>

    ServerAdmin webmaster@localhost

    ServerName $vhost_name.dev
    ServerAlias www.$vhost_name.dev

    DocumentRoot /home/$USER/workspace/$vhost_name

    ErrorLog /home/$USER/workspace/Logs/$vhost_name/error.log
    CustomLog /home/$USER/workspace/Logs/$vhost_name/access.log combined

    <Directory /home/$USER/workspace/$vhost_name>
      Require all granted
      AllowOverride all
    </Directory>

  </VirtualHost>
" > /etc/apache2/sites-available/$vhost_name.dev.conf
echo "  #Configurando apache..."



echo "$ip_vhost $vhost_name" > /etc/temp_hosts
chmod 777 /etc/temp_hosts
cat /etc/hosts >> /etc/temp_hosts
mv /etc/temp_hosts /etc/hosts

sudo a2ensite $vhost_name.dev.conf
sudo service apache2 restart

echo "<h1>vHost $vhost_name Criado com sucesso!!!" > /home/$USER/workspace/$vhost_name/index.html
google-chrome http://$vhost_name.dev

echo "  #Completo..."
