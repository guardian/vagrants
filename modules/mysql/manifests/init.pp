# Manage a MySQL installation
class mysql {

  file {
    '/etc/mysql/my.cnf':
      source => 'puppet:///modules/mysql/etc/mysql/my.cnf',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/root/mysql.setup':
      source => 'puppet:///modules/mysql/root/mysql.setup',
      owner  => root,
      group  => root,
      mode   => '0744';
  }

  package {
    [
      'mysql-server',
      'mysql-client'
    ]: ensure => latest;
  }

  service {
    'mysql':
      ensure => running,
      enable => true;
  }

  exec {
    'setup-mysql':
      cwd     => '/root',
      command => '/root/mysql.setup',
      creates => '/root/mysql.done';
  }

  File['/root/mysql.setup'] -> Exec['setup-mysql']

  Package['mysql-server'] ->
    File['/etc/mysql/my.cnf'] ->
    Service['mysql'] ->
    Exec['setup-mysql']
}