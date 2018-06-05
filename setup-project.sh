##################################
# Run this script to setup project from the vagrant home directory
#
# NOTE:
# >>>>> Setup Github credentials before running script
#

echo "What Git Repository to do want to clone?"
read gitclone

echo "Cloning Repository"
git clone $gitclone /var/www

echo "Installing Project Dependencies"
composer install -d /var/www

echo "Building .env file"
cp /var/www/.env.example /var/www/.env

echo "Generating Laravel Key"
php /var/www/artisan key:generate

echo "Linking Storage"
# if this fails make sure terminal is running as administrator
php /var/www/artisan storage:link

echo "Laravel installed"
php /var/www/artisan -V
