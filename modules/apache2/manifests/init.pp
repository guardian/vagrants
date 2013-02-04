# Manage an Apache2 installation
class apache2 {

  package {
    'apache2':
      ensure => latest;
  }

  service {
    'apache2':
      ensure => running,
      enable => true;
  }

  Package['apache2'] -> Service['apache2']
}