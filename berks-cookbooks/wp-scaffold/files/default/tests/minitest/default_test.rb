require File.expand_path('../support/helpers', __FILE__)
require 'minitest-chef-handler'

include Chef::Mixin::ShellOut

describe 'wp-scaffold::default' do

  include Helpers::Wp_scaffold

  it 'should run Wordpress on port 80' do
    assert shell_out("curl -sI http://localhost").exitstatus == 0
  end

  it 'should perform a default WP install' do
    assert shell_out("mysql -u root -e 'USE #{node['wordpress']['db']['database']}; SHOW TABLES;' -p#{node['mysql']['server_root_password']}")
              .stdout.include?("#{node['wordpress']['db']['prefix']}users")
  end
end
