# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.ssh.forward_agent = true

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef/cookbooks"]
    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "postgresql"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "rvm::system"
    chef.add_recipe "rvm::vagrant"
    chef.add_recipe "rvm::user"
    chef.json = {
      :rvm => {
        'user_installs' => [
          {
            'user' => 'vagrant',
            'default_ruby' => 'ruby-1.9.3-p429',
            'rubies' => ['ruby-1.9.3-p429']
          }
        ],
        "vagrant" => {
          "system_chef_client" => "/opt/chef/bin/chef-client",
          "system_solo_client" => "/opt/chef/bin/chef-solo"
        }
      },
      "postgresql" => {
        "password" => {
          "postgres" => "thiswilldofornow",
          "root" => "thiswilldofornow",
          "vagrant" => "vagrant"
        }
      }
    }
  end

  config.vm.provision :shell,
    :inline => "sudo -u vagrant createdb 5by5seenbot"
end
