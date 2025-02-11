# -*- mode: ruby -*-
# vi: set ft=ruby :

$etchosts = <<-SCRIPT
cp /etc/hosts /root && \
echo '\n192.168.56.100 ansible.devopstraining.com ansible' >> /etc/hosts && \
echo '192.168.56.101 web.devopstraining.com web' >> /etc/hosts
SCRIPT

Vagrant.configure("2") do |config|
  
  # Ansible szerver
  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "bento/rockylinux-9"
    ansible.vm.hostname = "ansible"
    ansible.vm.network "private_network", ip: "192.168.56.100"
    ansible.vm.synced_folder "./shared", "/shared"
    
    ansible.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
    
    # Hosts fájl módosítása
    ansible.vm.provision "shell", inline: $etchosts
    
    # Ansible telepítése
    ansible.vm.provision "shell", inline: <<-SHELL
      sudo dnf install -y epel-release
      sudo dnf install -y ansible git
    SHELL
  end

  # Web szerver
  config.vm.define "web" do |web|
    web.vm.box = "bento/rockylinux-9"
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.56.101"
    web.vm.network "forwarded_port", guest: 80, host: 8888
    web.vm.synced_folder "./shared", "/shared"
    
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "768"
    end

    # Hosts fájl módosítása
    web.vm.provision "shell", inline: $etchosts

    # Felhasználó létrehozása a Web szerveren
    web.vm.provision "shell", inline: <<-SHELL
      sudo useradd -m -p $(openssl passwd -1 homework) homework
      echo 'homework ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/homework
    SHELL
  end
end
