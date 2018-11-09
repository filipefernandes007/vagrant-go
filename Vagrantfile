# -*- mode: ruby -*-
# vi: set ft=ruby :
# https://github.com/rendom/vagrant-golang-webdev

require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))
parse = YAML.load_file("#{dir}/config/config.yaml")
java_installed = false

VAGRANT_NETWORK_IP = parse['public_network']

Vagrant.configure(2) do |config|
    config.vm.box = "bento/ubuntu-16.04"
    config.vm.hostname = parse['hostname']

    config.vm.network "private_network", ip: VAGRANT_NETWORK_IP

    config.vm.provision :shell, inline: <<-SCRIPT
                                            echo I am provisioning...
                                           SCRIPT

    # If you want to skip register hostname in /etc/hosts, use below
    # @see https://github.com/cogitatio/vagrant-hostsupdater
    if parse['dependencies']['hostsupdater'] == false
        config.vm.network "private_network", ip: VAGRANT_NETWORK_IP, hostsupdater: "skip"
    end

    config.vm.provision :shell, path: "scripts/bootstrap.sh"
    config.vm.provision :shell, privileged: false, path: "scripts/setup-app.sh"

    if parse['dependencies']['java-8'] == true
        java_installed = true
        config.vm.provision :shell, privileged: true, path: "scripts/setup-java-8.sh"
    end

    if parse['dependencies']['go'] == true
        config.vm.provision :shell, inline: "echo Installing Go..."
        config.vm.provision :shell, privileged: false, path: "scripts/setup-golang.sh"
        config.vm.network :forwarded_port, guest: 8085, host: 8085 # Go

        # config.vm.provision :shell, privileged: true, path: "scripts/go-packages.sh"
        config.vm.provision :shell, privileged: true, path: "scripts/setup-glide.sh"
    end

    if parse['dependencies']['redis'] == true
        config.vm.provision :shell, inline: "echo Installing Redis..."

        # depends on java : avoid install java twice
        if java_installed == false
           config.vm.provision :shell, privileged: true, path: "scripts/setup-java-8.sh"
           java_installed = true
        end

        config.vm.provision :shell, privileged: true, path: "scripts/setup-redis.sh"
        config.vm.network :forwarded_port, guest: 6379, host: 63790 # Redis
    end

    if parse['dependencies']['elasticsearch'] == true
        config.vm.provision :shell, inline: "echo Installing Elasticsearch..."
        config.vm.provision :shell, privileged: true, path: "scripts/setup-elasticsearch.sh"
        config.vm.network :forwarded_port, guest: 9200, host: 9200 # Elastic
    end

    if parse['dependencies']['nodejs'] == true
        config.vm.provision :shell, inline: "echo Installing NodeJS..."
        config.vm.provision :shell, path: "scripts/setup-nodejs.sh"
    end

    if parse['dependencies']['nginx'] == true
        config.vm.provision :shell, inline: "echo Installing nginx..."
        config.vm.provision :shell, path: "scripts/setup-nginx.sh"
        config.vm.network :forwarded_port, guest: 80, host: 8080 # Nginx http
        config.vm.network :forwarded_port, guest: 443, host: 8443 # Nginx ssl
        config.vm.network :forwarded_port, guest: 6666, host: 6666 # Nginx application
    end

    if parse['dependencies']['sqlite'] == true
        config.vm.provision :shell, inline: "echo Installing SQLite..."
        config.vm.provision :shell, privileged: true, path: "scripts/setup-sqlite.sh"
    end

    if parse['dependencies']['mongodb'] == true
        config.vm.provision :shell, inline: "echo Installing MongoDB..."
        config.vm.provision :shell, privileged: true, path: "scripts/setup-mongodb.sh"
    end

    if parse['dependencies']['mysql'] == true
        config.vm.provision :shell, inline: "echo Installing MySQL..."
        config.vm.provision :shell, privileged: true, path: "scripts/setup-mysql.sh", env: {"DB" => parse['database']}

        # if you get from MySQL client this message:
        # "The SSH Tunnel was unable to connect to host"
        # verify at ~/.ssh/known_hosts if 192.168.33.185 is already registered.
        # If so, remove that line
        config.vm.network :forwarded_port, guest: 3306, host: 8033 # Mariadb
    end

    config.vm.network :forwarded_port, guest: 2345, host: 2345, id: "debuggolang", host_ip: "localhost", auto_correct: true

    # config.vm.provision :shell, inline: "curl https://glide.sh/get | sh"

    config.vm.provision :shell, inline: <<-SCRIPT
                                        echo Finishing provisioning...
                                        echo $GOBIN
                                        SCRIPT

    # Applications folder
    config.vm.synced_folder "src/", "/home/vagrant/src/"

    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    #
    config.vm.provider "virtualbox" do |vb|
    #   # Display the VirtualBox GUI when booting the machine
    #   vb.gui = true
    #
    #   # Customize the amount of memory on the VM:
       vb.memory = "4096"
    end

    config.trigger.after :destroy do |trigger|
      trigger.info = "Removing known_hosts entries"
      trigger.run = {inline: "ssh-keygen -R #{VAGRANT_NETWORK_IP}"}
      #trigger.run = {inline: "ssh-keygen -R #{DOMAIN_NAME}"}
    end
end
