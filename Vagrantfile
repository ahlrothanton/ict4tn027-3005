# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  # disable synced folder
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # configure vagrant username and pass
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'

  # configure Metasploitable2 instance
  config.vm.define "metasploitable2" do |instance|
    # vagrant box
    instance.vm.box = "Sliim/metasploitable2"
    instance.vm.box_version = "2"

    # box didnt work with other credentials
    instance.ssh.username = "msfadmin"
    instance.ssh.password = "msfadmin"

    # network settings
    instance.vm.hostname = "metasploitable2"
    instance.vm.network "private_network", ip: '172.28.128.2'

    # define vm(s)
    instance.vm.provider "virtualbox" do |v|
      v.name = "metasploitable2"
      v.memory = 2048
    end
  end

  # Metasploitable3
  config.vm.define "metasploitable3" do |instance|
    instance.vm.box = "rapid7/metasploitable3-ub1404"

    instance.vm.hostname = "metasploitable3"
    instance.vm.network "private_network", ip: '172.28.128.3'

    instance.vm.provider "virtualbox" do |v|
      v.name = "metasploitable3"
      v.memory = 2048
    end
  end

  # WebGoat
  config.vm.define "webgoat" do |instance|
    instance.vm.box = "owaspwebgoat/webgoat"
    instance.vm.box_version = "8.0.M26"

    instance.vm.hostname = "webgoat"
    instance.vm.network "private_network", ip: '172.28.128.4'
    instance.vm.network "forwarded_port", guest: 8080, host: 8080
    instance.vm.network "forwarded_port", guest: 9090, host: 9090

    instance.vm.provider :virtualbox do |v|
      v.name = "webgoat"
      v.memory = 2048
    end

    instance.vm.provision "shell", inline: <<-SHELL
      echo "--- starting WebGoat server ---"
      nohup java -jar webgoat-server-8.0.0.M26.jar --server.port=8080 --server.address=0.0.0.0 &
    SHELL
  end

  # Kali
  config.vm.define "kali" do |instance|
    instance.vm.box = "kalilinux/rolling"

    instance.vm.hostname = "kali"
    instance.vm.network "private_network", ip: '172.28.128.10'

    instance.vm.disk :disk, size: "35GB", primary: true

    instance.vm.provider :virtualbox do |v|
      v.gui = false
      v.name = "kali"
      v.memory = 4096
      v.cpus = 2
    end

    # provision script
    instance.vm.provision "shell", inline: <<-SHELL
      apt-get update -qq
      sed -i 's/us/fi/g' /etc/default/keyboard
    SHELL
  end
end
