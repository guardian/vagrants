class apt-cacher-ng {

  package {
    apt-cacher-ng: ensure => latest;
  }

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/apt-cacher-ng/acng.conf":
      source => "puppet:///modules/boxgrinder/etc/apt-cacher-ng/acng.conf",
      notify => Service["apt-cacher-ng"];

     "/etc/apt-cacher-ng/ubuntu_security":
      source => "puppet:///modules/boxgrinder/etc/apt-cacher-ng/ubuntu_security",
      notify => Service["apt-cacher-ng"];
  }

  service {
    apt-cacher-ng: ensure => running;
  }

  Package["apt-cacher-ng"] ->
    File["/etc/apt-cacher-ng/acng.conf", "/etc/apt-cacher-ng/ubuntu_security"] ->
    Service["apt-cacher-ng"]
}