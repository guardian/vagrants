class guardian {

  group { "puppet": ensure => present; }

  include base-installation
  include apt
  include standard-packages

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/var/cache/downloads": ensure => directory;
  }

  Class["apt"] -> Class["standard-packages"]
}