# WP Scaffold
Manages dependencies with Composer, activates with WP CLI, and spins up a local development environment with Vagrant and Berkshelf.

# Requirements
* Vagrant
    * vagrant-berkshelf: Load Berkshelf managed cookbooks into Vagrant.
    * vagrant-omnibus: Automatically installs Chef on the Vagrant instance.
* Berkshelf: Manage cookbooks without Hosted Chef.

# Usage
* Create a project folder to hold the scaffold and corresponding site code.

        mkdir project_name
        cd project_name

* Clone the WP Scaffold repository into the project folder.

        git clone https://github.com/BlakeTidwell/wp-scaffold server

* Clone the site under development into the same parent directory, into a folder named `site`

        git clone https://github.com/YourAccount/project site

* You should now have a project structure as follows:

        project_name
        |_server
        |_site

* From within project_name/server, run `vagrant up`.

**TODO** Detail hosts config to work with private networking.