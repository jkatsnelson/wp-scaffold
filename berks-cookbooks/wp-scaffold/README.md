# wp-scaffold cookbook
Installs a simple stack for local development with Wordpress. Relies on Composer for dependency, and WP CLI for site, plugin, and theme activation.

# Requirements
* wordpress
* composer
* wp-cli

# Usage

# Attributes
node['wp_scaffold']['title'] - Site title (passed down to underlying `wordpress` cookbook)
node['wp_scaffold']['admin_user'] - Admin user for site
node['wp_scaffold']['admin_password'] - Self-explanatory
node['wp_scaffold']['dir'] - Directory in which Wordpress will be installed
node['wp_scaffold']['plugins']['include'] - Placeholder for plugins to activate during provisioning. Defaults to an empty array.
node['wp_scaffold']['plugins']['exclude'] - Alternately, plugins can be installed except for the ones specified. Placeholder for plugins to **exclude** during provisioning. Defaults to an empty array.

# Recipes
## Default
Does the namesake. Wordpress + plugin/theme dependencies + server stack.

# Author

Author:: Blake Tidwell ()
