#!/usr/bin/env bash
echo "Provisioning virtual machine..."

echo "Initial Update"
apt-get update -y  &> output.txt

echo "Installing Git"
apt-get install git -y &>> output.txt

echo "Installing Nginx"
apt-get install nginx -y &>> output.txt

echo "Updating PHP repository"
apt-get install python-software-properties build-essential -y &>> output.txt
add-apt-repository ppa:ondrej/php -y &>> output.txt
apt-get update -y &>> output.txt

echo "Installing PHP"
apt-get install php7.2-cli php7.2-dev php7.2-fpm -y &>> output.txt

echo "Installing PHP extensions"
apt-get install curl php7.2-curl php7.2-gd php7.2-mysql php7.2-mbstring php7.2-zip -y &>> output.txt
apt-get install libpcre3 -y &>> output.txt
//apt-get install php7.1-mcrypt -y &>> output.txt
apt-get install php7.2-xml -y &>> output.txt

echo "Configuring PHP"
cp /home/vagrant/provision/php-cli.ini /etc/php/7.2/cli/php.ini
cp /home/vagrant/provision/php-fpm.ini /etc/php/7.2/fpm/php.ini

echo "Installing PHPUnit"
wget https://phar.phpunit.de/phpunit.phar &>> output.txt
chmod +x phpunit.phar &>> output.txt
mv phpunit.phar /usr/local/bin/phpunit &>> output.txt

echo "Installing Composer"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer &>> output.txt
wait

echo "Installing Zip"
apt-get install zip -y &>> output.txt

echo "Preparing MySQL"
# debconf-utils allows the root password to be inputed as a command line argument, needed for installation
apt-get install debconf-utils -y &>> output.txt
debconf-set-selections <<< "mysql-server mysql-server/root_password password adidas"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password adidas"

echo "Installing MySQL"
apt-get install mysql-server -y &>> output.txt

echo "Configuring MySQL"
cp /var/provision/my.cnf /etc/mysql/my.cnf  &>> output.txt
sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf  &>> output.txt

# This will overwrite any changes to my.cnf made for bind-address
service mysql restart  &>> output.txt

echo "Configuring Nginx"
cp /home/vagrant/provision/nginx_vhost /etc/nginx/sites-available/nginx_vhost &>> output.txt
ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/  &>> output.txt
rm -rf /etc/nginx/sites-available/default  &>> output.txt
service nginx restart &>> output.txt

echo "Installing Node/NPM"
apt-get update -y &>> output.txt
apt-get install nodejs-legacy -y &>> output.txt
apt-get install npm -y &>> output.txt

#### Was using this to auto setup the project from provisioning but creates two problems composer runs as root and can't prompt for git repository
#/home/vagrant/setup-project.sh

echo "Bootstrap Complete!"
