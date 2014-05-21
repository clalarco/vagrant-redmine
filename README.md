vagrant-redmine
===============

Basic Vagrant configuration to have a ready to use Redmine site.

It uses Ubuntu 14.04 Trusty Thar as base system, using the included packages in this version:

- Redmine 2.4.2.stable
- Mysql 5.5
- Apache2 2.4.7-1


It does **not** configure:
- Secure site
- nginx option
- Other db engines (pgsql, sqlite)


Requirements
------------

**Vagrant**. Download from http://www.vagrantup.com/downloads.html
Version 1.5.1 was used for this configuration. 
Note: the included version in Ubuntu 12.04 (1.0.1) is not compatible with this configuration.

**Virtualbox**, required by Vagrant: https://www.virtualbox.org/wiki/Downloads

Note: For Ubuntu 12.04, the included virtualbox version is enough to perform all vagrant tasks. 


Quick Start up
--------------

1. Install / update Vagrant, from installer file from website.

2. and install virtualbox. From windows, using the installer. From Ubuntu: `sudo apt-get install virtualbox`.
3. Go to vagrant/ directory and write `vagrant up`. It will download box if needed and create vm.
4. If vagrant instance was not previously created, it will do the provision from bootstrap.sh.
5. When ready, you can open a browser and go to http://localhost:8888/redmine  user: admin, password:admin


Configuration
-------------

In bootstrap.sh you can set:

- Mysql and Redmine passwords. Notice that these passwords can be set 
through this script only when vagrant instance is created.
- Apache2 configuration.
- Extra packages you would like to install.

In Vagrantfile you can set:
- Machine cores and memory
- Extra provision scripts you would like to have
- Network type: NAT, bridge (public) or internal
- Port redirection
- All the settings available in Vagrant configuration.
