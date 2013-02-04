# Manage a Boxgrinder installation
class boxgrinder {

  include apt_cacher_ng

  apt::source {
    'boxgrinder':
      location    => 'http://ppa.launchpad.net/rubiojr/boxgrinder-stable/ubuntu',
      release     => 'precise',
      repos       => 'main',
      key         => 'F6BD82A0',
      key_server  => 'keyserver.ubuntu.com',
      include_src => false;
  }

  exec {
    'boxgrinder libguestfs-tools':
      environment => 'DEBIAN_FRONTEND=noninteractive',
      command     => '/usr/bin/apt-get -q -y -o DPkg::Options::=--force-confold install libguestfs-tools';
  }

  package {
    'boxgrinder-build': ensure => latest;
  }

  file {
    '/etc/vmbuilder.cfg':
      source => 'puppet:///modules/boxgrinder/etc/vmbuilder.cfg',
      owner  => root,
      group  => root,
      mode   => '0644';
  }

  Apt::Source['boxgrinder'] ->
    Exec['boxgrinder libguestfs-tools'] ->
    Package['boxgrinder-build']
}