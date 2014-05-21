#!/usr/bin/env bash
# Script to create a vagrant image with redmine ready to use.

set -x

# Set password. Change at your preference.
export MYSQL_PASSWORD='mysqlpasswd'
export REDMINE_PASSWORD='redminepwd'

# Set non-interactive instaler mode, update repos.
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update

# Install apache2
sudo apt-get install -q -y apache2 libapache2-mod-passenger

# Install mysql-server
echo 'mysql-server mysql-server/root_password password ${MYSQL_PASSWORD}' | sudo debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password ${MYSQL_PASSWORD}' | sudo debconf-set-selections
sudo apt-get install -q -y mysql-server mysql-client

# Install redmine.
echo 'redmine redmine/instances/default/mysql/app-pass password ${MYSQL_PASSWORD}' | sudo debconf-set-selections
echo 'redmine redmine/instances/default/mysql/admin-pass password ${MYSQL_PASSWORD}' | sudo debconf-set-selections
echo 'redmine redmine/instances/default/app-password password ${REDMINE_PASSWORD}' | sudo debconf-set-selections
echo 'redmine redmine/instances/default/app-password-confirm password ${REDMINE_PASSWORD}' | sudo debconf-set-selections
echo 'redmine redmine/instances/default/mysql/method select unix socket' | sudo debconf-set-selections
echo 'redmine redmine/instances/default/database-type select mysql' | sudo debconf-set-selections
echo 'redmine redmine/instances/default/dbconfig-install boolean true' | sudo debconf-set-selections
sudo apt-get install -q -y redmine-mysql
sudo apt-get install -q -y redmine

# Extras
sudo apt-get install imagemagick
sudo apt-get install ruby-rmagick

# Extra required package for ubuntu 14.04.
sudo gem install bundler

# Step required to allow to write Gemfile.lock.
sudo chown www-data:www-data /usr/share/redmine

# Link redmine into apache2.
sudo ln -s /usr/share/redmine/public /var/www/redmine

# Override apache settings.
sudo cat > /etc/apache2/sites-available/000-default.conf <<EOF
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        <Directory /var/www/redmine>
                RailsBaseURI /redmine
                PassengerResolveSymlinksInDocumentRoot on
        </Directory>
</VirtualHost>
EOF

# Configure passenger
sudo cat > /etc/apache2/mods-available/passenger.conf <<EOF
<IfModule mod_passenger.c>
  PassengerDefaultUser www-data
  PassengerRoot /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini
  PassengerDefaultRuby /usr/bin/ruby
</IfModule>
EOF

# Configure security messages.
sed -i 's|Server Tokens .*|Server Tokens Prod|g' /etc/apache2/conf-available/security.conf

# Restart apache2
sudo service apache2 restart

################################################
# Now you should be able to see redmine webpage
# http://localhost:8888/redmine
################################################
