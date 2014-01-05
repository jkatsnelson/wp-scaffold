# -*- mode: ruby -*-
# vi: set ft=ruby :

projectname = "scaffold"
repo_root = "/var/www/#{projectname}"
web_root = "/var/www/#{projectname}/public"

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = "local.wordpress.scaffold.com"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "opscode-centos-6.5"

  # Use Omnibus for box provisioning
  config.omnibus.chef_version = :latest

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # TODO: Configure using private network + NFS
  config.vm.network :private_network, ip: "33.33.33.10"

  # config.vm.network "forwarded_port", guest: 80, host: 4567

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.

  # config.vm.network :public_network

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # config.ssh.max_tries = 40
  # config.ssh.timeout   = 120

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "#{repo_root}"
  config.vm.synced_folder "./public", "#{web_root}"

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  # Available Wordpress cookbook attributes
  # node['wordpress']['version'] - Version of WordPress to download. Use 'latest' to download most recent version.
  # node['wordpress']['parent_dir'] - Parent directory to where WordPress will be installed.
  # node['wordpress']['dir'] - Location to place WordPress files.
  # node['wordpress']['db']['name'] - Name of the WordPress MySQL database.
  # node['wordpress']['db']['host'] - Host of the WordPress MySQL database.
  # node['wordpress']['db']['user'] - Name of the WordPress MySQL user.
  # node['wordpress']['db']['pass'] - Password of the WordPress MySQL user. By default, generated using openssl cookbook.
  # node['wordpress']['db']['prefix'] - Prefix of all MySQL tables created by WordPress.

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_debian_password => '7EiTyP82a37R3xnD4ZW26emLRYY3PX',
        :server_root_password => '7EiTyP82a37R3xnD4ZW26emLRYY3PX',
        :server_repl_password => '7EiTyP82a37R3xnD4ZW26emLRYY3PX'
        },
      :wordpress => {
        :parent_dir => repo_root,
        :dir => web_root,
        :db => {
          :name => "#{projectname}_wordpress",
          :user => "#{projectname}_admin",
          :pass => '7EiTyP82a37R3xnD4ZW26emLRYY3PX',
          :prefix => projectname
        }
      }
    }

    chef.run_list = [
        "recipe[wordpress::default]"
    ]
  end

  #
  config.vm.provision :shell do |shell|
    shell.inline = "sudo mount -t vboxsf -o uid=`id -u apache`,gid=`getent group apache | cut -d: -f3` #{web_root} #{web_root}"
  end
end
