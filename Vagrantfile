# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.c
# configures the configuration version (we support older styles
# backwards compatibility). Please don't change it unless you k
# you're doing.
Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/xenial64"

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
    end

    config.vm.network "forwarded_port", guest: 80, host: 8000
    #config.vm.network "forwarded_port", guest: 8080, host: 8080
    #config.vm.network "forwarded_port", guest: 5776, host: 5776

    config.vm.synced_folder ".", "/vagrant",
        owner: "ubuntu", group: "www-data"

    #config.ssh.private_key_path = '~/.ssh/id_rsa'
    config.ssh.forward_agent = true
end

