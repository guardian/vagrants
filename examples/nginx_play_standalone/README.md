`nginx_play_standalone`
=======================

A standalone NGINX instance demonstrating a proxy configuration suitable for a
Play application server on the same box.

To use this VM configuration in your own project:

* Copy the `VagrantFile` and `vagrant` directory to the root of your source
  tree.
* Change the `config.vm.box_url` setting in `VagrantFile` to point to a URL
  containing the box image.
* `vagrant up` in your source tree root.
* Repurpose `README.vagrant.md` into your project documentation.
