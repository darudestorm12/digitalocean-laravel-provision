#!/bin/sh
sudo apt-get -y update
sudo apt-get -y upgrade

#install packages
sudo apt-get -y install php5-cli git
sudo php5enmod mcrypt
sudo service php5-fpm restart

 

#installcomposer
sudo curl -sS https://getcomposer.org/installer | php5
sudo mv composer.phar /usr/local/bin/composer

#make swap
sudo fallocate -l 1G /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

#setup site
sudo mkdir -p /var/www/laravel/
rm -f /etc/nginx/sites-available/default
cat > /etc/nginx/sites-available/default << EOF
server {
    listen 80 default_server;

    root /var/www/laravel/public;
    index index.php index.html index.htm;

    server_name _;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        try_files \$uri /index.php =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)\$;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
}
EOF
sudo service nginx restart 

 

#install laravel
sudo composer global require "laravel/installer=~1.1"
sudo composer create-project laravel/laravel /var/www/laravel --prefer-dist

 
#this is bad practice but I was done with it. 
#I just ran the whole thing as root on a droplet that was only up for minutes
#you should NOT do this on a production server
# 
#Proper way would be to create a user, chown -R user:www-data
#and then chmod -r storage/ and vendor/ to 770 or 775 
sudo chmod -R 777 /var/www/laravel/