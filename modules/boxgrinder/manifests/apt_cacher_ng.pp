# Apt caching service
class boxgrinder::apt_cacher_ng {

  package {
    'apt-cacher-ng': ensure => latest;
  }

  file {
    '/etc/apt-cacher-ng/acng.conf':
      source => 'puppet:///modules/boxgrinder/etc/apt-cacher-ng/acng.conf',
      notify => Service['apt-cacher-ng'],
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/apt-cacher-ng/ubuntu_security':
      source => 'puppet:///modules/boxgrinder/etc/apt-cacher-ng/ubuntu_security',
      notify => Service['apt-cacher-ng'],
      owner  => root,
      group  => root,
      mode   => '0644';
  }

  service {
    'apt-cacher-ng':
      ensure => running,
      enable => true;
  }

  Package['apt-cacher-ng'] ->
    File['/etc/apt-cacher-ng/acng.conf'] ->
    Service['apt-cacher-ng']

  Package['apt-cacher-ng'] ->
    File['/etc/apt-cacher-ng/ubuntu_security'] ->
    Service['apt-cacher-ng']
}