class guardian {

  group { "puppet": ensure => present; }

  include base-installation
  include apt
  include standard-packages

  Class["apt"] -> Class["standard-packages"]
}