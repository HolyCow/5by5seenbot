# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

   config.vm.provision :shell,
    :inline => "sudo apt-get update"

   config.vm.provision :shell,
    :inline => "sudo apt-get -y install curl"

   config.vm.provision :shell,
    :inline => "curl -L get.rvm.io | bash -s stable"

   config.vm.provision :shell,
    :inline => "rvm autolibs enable"

   config.vm.provision :shell,
    :inline => "rvm install 1.9.3"

   config.vm.provision :shell,
    :inline => "cd /vagrant"

   config.vm.provision :shell,
    :inline => "rvm use --default 1.9.3"

   config.vm.provision :shell,
    :inline => "gem install bundler"

   config.vm.provision :shell,
    :inline => "bundle"

   config.vm.provision :shell,
    :inline => "bundle install"
end
