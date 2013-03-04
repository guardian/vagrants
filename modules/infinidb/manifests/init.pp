# Manage an InfiniDB installation
class infinidb {

  $url = 'http://infinidb.org/dmdocuments'
  $filename = 'calpont-infinidb-2.2.11-1.amd64.deb.tar.gz'

  exec {
    'download-infinidb':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      timeout => 0;

    'extract-infinidb':
      command => "/bin/tar xzvf ${filename}",
      cwd     => '/root',
      creates => '/root/calpont_2.2.11-1_amd64.deb',
      timeout => 0;
  }

  package {
    'calpont':
      ensure   => installed,
      provider => dpkg,
      source   => '/root/calpont_2.2.11-1_amd64.deb';

    'calpont-mysql':
      ensure   => installed,
      provider => dpkg,
      source   => '/root/calpont-mysql_2.2.11-1_amd64.deb';

    'calpont-mysqld':
      ensure   => installed,
      provider => dpkg,
      source   => '/root/calpont-mysqld_2.2.11-1_amd64.deb';
  }

  file {
    '/usr/local/Calpont/mysql/my.cnf':
      source => 'puppet:///modules/infinidb/usr/local/Calpont/mysql/my.cnf',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/root/infinidb.setup':
      source => 'puppet:///modules/infinidb/root/infinidb.setup',
      owner  => root,
      group  => root,
      mode   => '0744';
  }

  exec {
    'setup-infinidb':
      cwd     => '/root',
      command => '/root/infinidb.setup',
      creates => '/root/infinidb.done';
  }

  service {
    'infinidb':
      ensure => running,
      enable => true;
  }

  Exec['extract-infinidb'] -> Package['calpont'] -> Service['infinidb']
  Exec['extract-infinidb'] -> Package['calpont-mysql'] -> Service['infinidb']
  Exec['extract-infinidb'] -> Package['calpont-mysqld'] -> Service['infinidb']

  Package['calpont-mysqld'] ->
    File['/usr/local/Calpont/mysql/my.cnf'] ->
    File['/root/infinidb.setup'] ->
    Exec['setup-infinidb'] ->
    Service['infinidb']
}