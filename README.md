vagrant-redmine
===============

Basic Vagrant configuration to have a ready to use Redmine site.

It uses Ubuntu 14.04 Trusty Thar as base system, using the included packages in this version:

- Redmine 2.4.2.stable
- Mysql 5.5
- sqlite 3.8.2
- postgres 9.3
- Apache2 2.4.7-1
- nginx 1.4.6

It does **not** configure:
- Secure site (yet)
- Use redmine in a subdomain/virtual server


Requirements
------------

**Vagrant**. Download from http://www.vagrantup.com/downloads.html
Version 1.5.1 was used for this configuration.

Note: The included Vagrant version in Ubuntu 12.04 (1.0.1) is not compatible with this configuration. You need to install/update it from .deb installer.

**Virtualbox**, required by Vagrant: https://www.virtualbox.org/wiki/Downloads

Note: For Ubuntu 12.04, the included virtualbox version is enough to perform all vagrant tasks. 


Quick Start up
--------------

1. Install / update Vagrant, from installer file from website.
2. Install virtualbox. From windows, using the installer. From Ubuntu: `sudo apt-get install virtualbox`.
3. Go to vagrant/ directory and write `vagrant up`. It will download box if needed and create vm.
4. If vagrant instance was not previously created, it will do the provision from bootstrap.sh.
5. When ready, you can open a browser and go to http://localhost:8888 user: admin, password:admin


Configuration
-------------

In bootstrap.sh you can set:
- Which database to use: sqlite, mysql or postgres (not sure if last one is working)
- Which web server to use: nginx or apache2
- Database and Redmine passwords. Notice that these passwords can be set 
through this script only when vagrant instance is created.
- Apache2/nginx configuration.
- Extra imagemagick packages if you'd like to install them.


In Vagrantfile you can set:
- Machine cores and memory
- Extra provision scripts you would like to have
- Network type: NAT, bridge (public) or internal
- Port redirection
- All the settings available in Vagrant configuration.


TODO
----

- Verify if pgsql is working
- Set up secure mode
- Allow to backup/restore when provisioning instance


References
----------
- Vagrant website: http://www.vagrantup.com/
- How to install Redmine in Ubuntu Step by Step: http://www.redmine.org/projects/redmine/wiki/HowTo_Install_Redmine_on_Ubuntu_step_by_step
- http://www.redmine.org/projects/redmine/wiki/HowTo_configure_Nginx_to_run_Redmine
