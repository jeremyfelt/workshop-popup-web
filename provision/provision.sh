# This file is specified as the provisioning script to be used during `vagrant up`
# via the `config.vm.provision` parameter in the Vagrantfile.

apt-get update --force-yes -y

# PACKAGE INSTALLATION
#
# Build a bash array to pass all of the packages we want to install to
# a single apt-get command. This avoids having to do all the leg work
# each time a package is set to install. It also allows us to easily comment
# out or add single packages.
apt_package_list=(

	# PHP5
	php5-fpm
	php5-cli
	
	# Common and dev packages for php
	php5-common

	# nginx
	nginx

	# MISC Packages
	ack-grep
	git-core
	vim
	dos2unix
)

printf "Install all apt-get packages...\n"
apt-get install --force-yes -y ${apt_package_list[@]}

# Clean up apt caches
apt-get clean

# SYMLINK HOST FILES
printf "\nLink Directories...\n"

# Configuration for nginx
sudo ln -sf /srv/config/nginx-config/nginx.conf /etc/nginx/nginx.conf | echo "Linked nginx.conf to /etc/nginx/"

# Configuration for php5-fpm
sudo ln -sf /srv/config/php5-fpm-config/www.conf /etc/php5/fpm/pool.d/www.conf | echo "Linked www.conf to /etc/php5/fpm/pool.d/"
sudo ln -sf /srv/config/php5-fpm-config/php.ini /etc/php5/fpm/php.ini | echo "Linked php.ini to /etc/php5/fpm/"

# RESTART SERVICES
#
# Make sure the services we expect to be running are running.
printf "\nRestart services...\n"
printf "\nservice nginx restart\n"
sudo service nginx restart
printf "\nservice php5-fpm restart\n"
sudo service php5-fpm restart

# Your host IP is set in Vagrantfile, but it's nice to see the interfaces anyway
ifconfig | grep "inet addr"
echo All set!
