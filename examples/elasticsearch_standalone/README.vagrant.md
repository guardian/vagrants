Vagrant
=======

Preliminaries: Install Vagrant(Ubuntu)
--------------------------------------
[Vagrant][vagrant] is a tool to "create and configure lightweight, reproducible,
and portable development environments." Vagrant itself is a virtual instance
creation and startup tool on top of Oracle VirtualBox which takes care of the
virtualisation.

Install the Open Source Edition of VirtualBox:

    wget http://download.virtualbox.org/virtualbox/4.1.18/virtualbox-4.1_4.1.18-78361~Ubuntu~natty_amd64.deb
    sudo dpkg -i virtualbox-4.1_4.1.18-78361~Ubuntu~natty_amd64.deb

If you are using a different version of Ubuntu, substitute the appropriate
deb from the [VirtualBox download page][virtualbox-download].

Then install Vagrant itself:

    wget http://files.vagrantup.com/packages/eb590aa3d936ac71cbf9c64cf207f148ddfc000a/vagrant_1.0.3_x86_64.deb
    sudo dpkg -i vagrant_1.0.3_x86_64.deb


Creating the VM
---------------
Start the VMs defined in `VagrantFile`:

    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

A number of ElasticSearch plugins are included. See:

    http://localhost:9200/_plugin/head/
    http://localhost:9200/_plugin/paramedic/index.html
    http://localhost:9200/_plugin/bigdesk/


Vagrant Commmands
-----------------

* `/opt/vagrant/bin/vagrant suspend`: Disable the virtual instance. The
  allocated disc space for the instance is retained but the instance will not be
  available. The running state at suspend time is saved for resumption.
* `/opt/vagrant/bin/vagrant resume`: Wake up a previously suspended virtual
  instance.
* `/opt/vagrant/bin/vagrant halt`: Turn off the virtual instance. Calling
  `vagrant up` after this is the equivalent of a reboot.
* `/opt/vagrant/bin/vagrant up --no-provision`: Bring up the virtual instance
  without doing the provisioning step. Useful if the provisioning step is
  destructive.
* `/opt/vagrant/bin/vagrant destroy`: Hose your virtual instance, reclaiming the
  allocated disc space.
* `/opt/vagrant/bin/vagrant provision`: Rerun puppet or chef provisioning on the
  virtual instance.


Vagrant SSH X Forwarding
------------------------
X applications on VMs can be displayed on the host machine by specifying a
Vagrant SSH connection with X11 forwarding in the `Vagrantfile`:

    config.ssh.forward_x11 = true

On the host machine, add an `xhost` for the Vagrant VM:

    xhost +10.0.0.2

Then X applications started from the VM should display on the host machine.


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


[vagrant]: http://vagrantup.com
[virtualbox-download]: https://www.virtualbox.org/wiki/Linux_Downloads
