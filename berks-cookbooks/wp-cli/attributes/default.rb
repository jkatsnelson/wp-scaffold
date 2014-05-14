#
# Cookbook Name:: wp-cli
# Attributes:: default
#
# Author:: Takayuki Miyauchi
# License: MIT
#

default['wp-cli']['wpcli-dir'] = '/usr/share/wp-cli'
default['wp-cli']['wpcli-link'] = '/usr/bin/wp'
default['wp-cli']['installer'] = 'https://raw.github.com/wp-cli/wp-cli.github.com/master/installer.sh'
default['wp-cli']['site']['dir'] = node['wordpress']['dir']