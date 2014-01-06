# -*- mode: ruby -*-
# vi: set ft=ruby :

WP_PROJECT_TYPES = ["site", "plugin", "theme"]

# User configurable environment variables.
# Override these, for example, in .exports file.
WP_ENVIRONMENT = {
  'WP_IP' => '33.33.33.30',
  'WP_HOSTNAME' => 'local.wordpress.scaffold.com',
  'WP_PROJECT_NAME' => 'scaffold',
  'WP_PROJECT_TYPE' => 'site'
}

# Set default for variables not found in environment.
WP_ENVIRONMENT.each do |env_name, default|
  value = ENV[env_name].nil? ? default : ENV[env_name]
  Object.const_set(env_name, value)
end

# Public root is the same regardless of project type.
WP_ROOT = "/var/www/#{WP_PROJECT_NAME}"

case WP_PROJECT_TYPE
when "site"
  # Symlink entire site, including plugins and themes.
  SOURCE_DIR = "../sites/#{WP_PROJECT_NAME}"
  TARGET_DIR = "/var/www/#{WP_PROJECT_NAME}"
when "plugin"
  puts "Plugin scaffold unimplemented."
when "theme"
  puts "Theme scaffold unimplemented."
else
  abort "Unrecognized project type \"#{WP_PROJECT_TYPE}\" set for WP_PROJECT_TYPE (should be one of #{WP_PROJECT_TYPES.join(', ')})."
end

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = WP_HOSTNAME

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "opscode-centos-6.5"

  # Use Omnibus for box provisioning
  config.omnibus.chef_version = :latest

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # TODO: Configure using private network + NFS
  config.vm.network :private_network, ip: WP_IP

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder SOURCE_DIR, TARGET_DIR

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
        :dir => WP_ROOT,
        :db => {
          :pass => '7EiTyP82a37R3xnD4ZW26emLRYY3PX'
        }
      }
    }

    chef.add_recipe "wordpress::default"
    chef.add_recipe "wp-cli::default"
    chef.add_recipe "composer::default"
  end

  #
  config.vm.provision :shell do |shell|
    shell.inline = "sudo mount -t vboxsf -o uid=`id -u apache`,gid=`getent group apache | cut -d: -f3` #{TARGET_DIR} #{TARGET_DIR}"
  end
end
