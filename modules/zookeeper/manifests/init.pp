# Manage a Zookeeper installation
class zookeeper {

  require java

  package {
    'zookeeperd': ensure => latest;
  }

  service {
    'zookeeper':
      ensure => running,
      enable => true;
  }

  Package['zookeeperd'] -> Service['zookeeper']
}