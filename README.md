# m1-stack

A docker-compose stack for Magento 1.9 CE or EE. Maybe works for previous versions.

Uses PHP 7.0 although not officially supported in CE, seem to work.

Suitable for testing Magento customizations from a standard Magento.


## Usage

* Install (see Setup)
* `make` to see the possible common actions
* `make check` to check if docker is installed and see the final docker-compose config. Do this if you need to configure `.env` and `docker-compose.override.yml` before starting the stack
* `make run` to start the stack, Ctrl+C to stop it

Default configured vhosts are (create/configure the matching websites/stores in magento if needed):
* `http://magento1.local/`: default store
* `http://magento1-website2.local/`: uses "website2_default" store
* `http://magento1-website3.local/`: uses "website3_default" store

Mailcatcher: `http://localhost:8025/`

Start debugging sessions using one of the xdebug toolbar extensions for your browser.

In case you want to change the php or apache config:
* Stop the stack
* Change the required files
* Run `make build` (docker-compose build)
* Start the stack

Examples of config files you'd like to change:
* `apache/etc/php/7.0/common/50-common-additional.ini`
* `apache/etc/apache2/sites-enabled/*`

It is also possible to use volumes to override config files from the docker-compose.override.yml file

## Setup

* Add the required hosts to your `/etc/hosts`
    * example: `127.0.0.1	magento1.local magento1-website2.local magento1-website3.local`
* Install Magento files in `magento/`:
    * Download the Magento source and unpack it from here, example: `tar xzf ~/Downloads/magento-1.9.4.3-2019-10-08-05-28-41.tar.gz` (it should put the magento files in magento/ dir) ; or install your own source
* (Optional) Install sample data :
    * Download the sample data for your version ( https://magento.com/tech-resources/download ) and unpack it somewhere
    * Copy the sql script in `mysql/initdb.d/`
    * Add the contents of media and skin to the magento source, example: `cp -rv magento-sample-data-1.9.2.4/{media,skin} magento/`
* Start the stack: `make run`
    * It will build containers if needed, create database and install sample data if provided
* Install Magento
    * Run `./install.sh` or go to the frontend (`http://magento1.local`) to do the setup by wizard or run a custom install.php command (see install.sh)
    * **Warning**: install.sh *locks* the code files (see "File permissions management"), so run `./unlockfs.sh` if you intend to edit the code
    * Go to the backend or frontend with the information given by install.sh 

### File permissions management

In the last M1 versions, the policy is to have a single user for both code ownership and code execution. That is what is done in this stack (the code owner, the command line user and the webserver user are ther same).

It is simple, but to avoid source file modifications by running scripts, the code files are "protected" by removing the write privilege on the owner.

That's what is suggested by Magento and it is done too in this stack when running ./install.sh (which calls lockfs.sh). So if you intend to modify code (or, even opening the magento directory in an IDE), you should run `./unlockfs.sh`. Run `./lockfs.sh` when no more code modifications are needed (ex: after installation or after installing an extension).

See: https://devdocs.magento.com/guides/m1x/install/installer-privileges_after.html#privs-after

### Start over

* Stop the stack
* Remove the containers and their linked data volumes: `docker-compose down --volumes` (or `make clear`)
* Remove the `magento/` dir and put back the original source (+ sample data if needed)
* Start the stack


