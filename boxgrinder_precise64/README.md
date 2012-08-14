Boxgrinder
==========

Ignore the boxgrinder meta appliance. Use the accompanying `Vagrantfile` definition to create an Ubuntu box instead.

(Needs manual intervention because of non-interactive apt packages.)


Grind an Ubuntu box:

    #export BOXGRINDER_DEBUG_NOCLEAN=1
    export BOXGRINDER_DEBUG_VMBUILDER=1
    boxgrinder-build -l boxgrinder-ubuntu-plugin /vagrant/precise.appl -p virtualbox



[boxgrinder-ubuntu]: https://github.com/rubiojr/boxgrinder-ubuntu-plugin




vmdk to Vagrant box
===================
Start the vmdk in VirtualBox. The root password is `boxgrinder`.

Use the accompanying `prepare-ubuntu-vagrant.sh` to apply the necessary Vagrant configuration to the VirtualBox VM. Export to Vagrant using e.g.:

    vagrant package --base test --output test.box

Test with `Vagrantfile`:

Vagrant::Config.run do |config|

  config.vm.box = "test"
  config.vm.box_url = "path/to/test.box"

  # config.vm.boot_mode = :gui
  config.ssh.forward_x11 = true

end



Additional information on base boxes: 
    http://vagrantup.com/v1/docs/base_boxes.html
    http://www.yodi.me/blog/2011/10/26/build-base-box-vagrant-ubuntu-oneiric-11.10-server/



Update the Guest Additions in a Vagrant box
===========================================

See http://hedgehogshiatus.com/upgrade-virtualbox-guest-additions-in-a-vargr

Or: http://blog.carlossanchez.eu/2012/05/03/automatically-download-and-install-virtualbox-guest-additions-in-vagrant/


