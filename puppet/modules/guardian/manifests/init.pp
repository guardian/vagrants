class guardian {

  include base-installation
  include apt
  include standard-packages

  service { ntp: ensure => running }

  Class["apt"] -> Class["standard-packages"] -> Service["ntp"]
}