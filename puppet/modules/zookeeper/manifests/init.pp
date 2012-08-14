class zookeeper {

  include guardian

  package {
    zookeeperd: ensure => latest;
  }

  service {
    zookeeper: ensure => running;
  }

  Class["guardian"] ->
    Package["zookeeperd"] ->
    Service["zookeeper"]
}