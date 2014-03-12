# -*- mode: ruby -*-
# vi: set ft=ruby :

WP_IP = '33.33.33.30'
WP_PROJECT_NAME = 'scaffold'
WP_HOSTNAME = "local.#{WP_PROJECT_NAME}.wordpress.dev"

# Public root is the same regardless of project type.
WP_ROOT = "/var/www/#{WP_PROJECT_NAME}"

# Symlink entire site, including plugins and themes.
SOURCE_DIR = "../site"
TARGET_DIR = "/var/www/#{WP_PROJECT_NAME}"

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = WP_HOSTNAME

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "opscode_centos-6.5"

  # Use Omnibus for box provisioning
  config.omnibus.chef_version = :latest

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # Chef Zero?!
  config.chef_zero.enabled = true
  config.chef_zero.cookbooks = "#{ENV['HOME']}/Code/ops_workspace/cookbooks"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: WP_IP

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder SOURCE_DIR, TARGET_DIR

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.provision :chef_client do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => '9237e4cd4030be8c4b45c7972e5eeb8a',
        :server_debian_password => '9237e4cd4030be8c4b45c7972e5eeb8a',
        :server_repl_password => '9237e4cd4030be8c4b45c7972e5eeb8a'
      },
      :wordpress => {
        :dir => TARGET_DIR
      },
      :wp_scaffold => {
        # Can also override admin name and pass
        :admin_email => 'test@test.com',
        :plugins => {
          # :include => []
          # :exclude => []
        }
      }
    }

    chef.run_list = [
        "recipe[wp-scaffold::default]"
    ]
  end
end
