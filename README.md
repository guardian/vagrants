Vagrant Development Boxes
=========================

Preliminaries: Install Vagrant(Ubuntu)
--------------------------------------
[Vagrant][vagrant] is a tool to "create and configure lightweight, reproducible,
and portable development environments." Vagrant itself is a virtual instance
creation and startup tool on top of Oracle VirtualBox which takes care of the
virtualisation.

Install the Open Source Edition of VirtualBox and Vagrant itself:

    sudo apt-get install virtualbox-ose
    wget http://files.vagrantup.com/packages/eb590aa3d936ac71cbf9c64cf207f148ddfc000a/vagrant_1.0.3_x86_64.deb
    sudo dpkg -i vagrant_1.0.3_x86_64.deb


Preliminaries: IntelliJ Project Files
-------------------------------------
Because this is not a builded project, there is no support for automatically
creating IntelliJ project definitions. If you want to use the IntelliJ editors
you will need to create a new project in IntelliJ. Use the Create project from
existing sources, unmark the source files that IntelliJ finds and confirm
project creation.

In the new project, go to Project Structure and create a new module from scratch
specifying the project base directory as the content root. Do not create a
source directory and finish. In the newly constructed module, add the project
base directory as a sources directory.

Your project should now be setup for editing.


`base_precise64`
--------------
Basic Ubuntu 12.04 box with `/etc/gu`, apt configuration and Java.

    /opt/vagrant/bin/vagrant init base_precise64 http://path-to-frontend_base64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch:

    cd base_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output base_precise64.box

The puppet provisioning during the `vagrant up` step may take some time to
download the Java packages.


`play_precise64`
--------------
The basic Ubuntu box with NGINX and a server configuration suitable for a Play
Framework application. This box supports Guardian [frontend][frontend].

    /opt/vagrant/bin/vagrant init play_precise64 http://path-to-play_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch, first build `base_precise64`, then::

    cd play_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output play_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 80 to the host machine. Port
9000 is also useful for direct access to the Play Framework application.

    config.vm.forward_port 80, 8000
    config.vm.forward_port 9000, 9000

This forwards port 80 to port 8000 on the host machine to avoid clashes with
existing webservers on the host box.


`play_extras_precise64`
---------------------
A version of `play_precise64` with ElasticSearch and Mongodb.

    /opt/vagrant/bin/vagrant init play_extras_precise64 http://path-to-play_extras_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch, first build `play_precise64`, then:

    cd play_extras_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output play_extras_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 80 to the host machine. Port
9000 is also useful for direct access to the Play Framework application.

    config.vm.forward_port 80, 8000
    config.vm.forward_port 9000, 9000

This forwards port 80 to port 8000 on the host machine to avoid clashes with
existing webservers on the host box.

In addition, forward port 9200 for ElasticSearch.

    config.vm.forward_port 9200, 9200

A number of ElasticSearch plugins are included in this box. See:

    http://localhost:9200/_plugin/head/
    http://localhost:9200/_plugin/paramedic/index.html
    http://localhost:9200/_plugin/bigdesk/

Forward ports 27017 and 28017 to the host machine for MongoDB.

    config.vm.forward_port 27017, 27017
    config.vm.forward_port 28017, 28017

The MongoDB web interface is available:

    http://localhost:28017


Vagrant Commmands
-----------------

* `/opt/vagrant/bin/vagrant suspend`: Disable the virtual instance. The
  allocated disc space for the instance is retained but the instance will not be
  available. The running state at suspend time is saved for resumption.
* `/opt/vagrant/bin/vagrant resume`: Wake up a previously suspended virtual
  instance.
* `/opt/vagrant/bin/vagrant halt`: Turn off the virtual instance. Calling
  `vagrant up` after this is the equivalent of a reboot.
* `/opt/vagrant/bin/vagrant destroy`: Hose your virtual instance, reclaiming the
  allocated disc space.
* `/opt/vagrant/bin/vagrant provision`: Rerun puppet or chef provisioning on the
  virtual instance.


Vagrant Troubleshooting
-----------------------

To see more verbose output on any vagrant command, add a VAGRANT_LOG environment
variable setting, e.g.:

    VAGRANT_LOG=INFO /opt/vagrant/bin/vagrant up

Further help troubleshooting can be obtained by editing your `Vagrantfile` and
enabling the `config.vm.boot_mode = :gui` setting. This will pop up a VirtualBox
GUI window on boot.

There have been some issues getting 64bit instances to start. The error is
apparent in GUI boot:

    VT-x/AMD-V hardware acceleration has been enabled, but is not
    operational. Your 64-bit guest will fail to detect a 64-bit CPU and
    will not be able to boot.

Some BIOS setting changes can help. The changes are described at
`http://dba-star.blogspot.com/2011/11/how-to-enable-vtx-and-vtd-on-hp-compaq.html`
but briefly:

1. Restart your developer box.
2. Press F10 for BIOS settings at the boot splash.
3. Edit Security -> System Security (I wasn't expecting it here either!)
4. Enable VT-x and VT-d settings.
5. Save and exit.



[frontend]: https://github.com/guardian/frontend
[vagrant]: http://vagrantup.com
