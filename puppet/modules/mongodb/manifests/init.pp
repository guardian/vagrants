class mongodb {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    '/etc/apt/sources.list.d': ensure => directory;

    '/etc/apt/sources.list.d/10gen-lucid.list':
      source => 'puppet:///modules/mongodb/etc/apt/sources.list.d/10gen-lucid.list';

    '/etc/apt/trusted.gpg.d/10gen.gpg':
      source => 'puppet:///modules/mongodb/etc/apt/trusted.gpg.d/10gen.gpg';
  }

  exec {
    apt-add-10gen-key:
      command => '/usr/bin/apt-get update',
      subscribe => File['/etc/apt/trusted.gpg.d/10gen.gpg'],
      refreshonly => true;
  }

  package {
    mongodb-10gen:
      ensure => installed,
      require => [
        File['/etc/apt/sources.list.d/10gen-lucid.list'],
        Exec['apt-add-10gen-key']
      ];
  }

  service {
    mongodb:
      ensure => running,
      require => Package['mongodb-10gen'];
  }
}
