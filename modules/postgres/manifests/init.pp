# Manage a MySQL installation
class postgres {

  package {
    [
      'postgresql',
      'postgresql-client'
    ]: ensure => latest;
  }

  service {
    'postgresql':
      ensure => running,
      enable => true;
  }

  Package['postgresql'] -> Service['postgresql']
}