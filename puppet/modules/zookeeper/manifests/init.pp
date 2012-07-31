class zookeeper {

  include guardian

  package {
    zookeeperd: ensure => installed;
  }

  service {
    zookeeper: ensure => running;
  }

  Class["guardian"] ->
    Package["zookeeperd"] ->
    Service["zookeeper"]
}