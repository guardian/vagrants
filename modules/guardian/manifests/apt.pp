# Manage the apt configuration and run an update
class guardian::apt {

  file {
    [
      '/etc/apt',
      '/etc/apt/apt.conf.d'
    ]:
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755';

    # Use GB default repository sources
    '/etc/apt/sources.list':
      source => 'puppet:///modules/guardian/etc/apt/sources.list.gb',
      owner  => root,
      group  => root,
      mode   => '0644';

    # Need a long timeout for download virus checks
    '/etc/apt/apt.conf.d/30timeout':
      source => 'puppet:///modules/guardian/etc/apt/apt.conf.d/30timeout',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/apt/apt.conf.d/31retries':
      source => 'puppet:///modules/guardian/etc/apt/apt.conf.d/31retries',
      owner  => root,
      group  => root,
      mode   => '0644';
  }

  exec {
    'apt-get update': command => '/usr/bin/apt-get update';
  }

  File['/etc/apt/sources.list'] -> Exec['apt-get update']
  File['/etc/apt/apt.conf.d/30timeout'] -> Exec['apt-get update']
  File['/etc/apt/apt.conf.d/31retries'] -> Exec['apt-get update']
}
