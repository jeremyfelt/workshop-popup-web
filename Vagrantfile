# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provider :virtualbox do |v|
	v.customize ["modifyvm", :id, "--memory", 256]
  end
  
  # Default Ubuntu Box
  #
  # This box is provided by Vagrant at vagrantup.com and is a nicely sized (290MB)
  # box containing the Unbuntu 12.0.4 Precise 32 bit release.
  config.vm.box = "std-precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.hostname = "workshop-web"

  # IP address pulled from DHCP on the local network
  config.vm.network :public_network

  config.vm.synced_folder "config", "/srv/config/" 
  config.vm.synced_folder "config/nginx-config/sites/", "/etc/nginx/custom-sites"
  config.vm.synced_folder "www/", "/srv/www/", :owner => "www-data"

  config.vm.provision :shell, :path => "provision/provision.sh"
end
