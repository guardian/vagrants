class zookeeper {

  include guardian

  package {
    zookeeper: ensure => installed;
  }

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/usr/share/zookeeper/conf": ensure => directory;

    "/usr/share/zookeeper/conf/zoo.cfg":
      require => File["/usr/share/zookeeper/conf"],
      source => "puppet:///modules/zookeeper/usr/share/zookeeper/conf/zoo.cfg";
  }

  service {
    zookeeper:
      provider => "init",
      hasstatus => true,
      start => "/usr/share/zookeeper/bin/zkServer.sh start",
      status => "/usr/share/zookeeper/bin/zkServer.sh status",
      stop => "/usr/share/zookeeper/bin/zkServer.sh stop",
      ensure => running;
  }

  Class["guardian"] ->
    Package["zookeeper"] ->
    File["/usr/share/zookeeper/conf", "/usr/share/zookeeper/conf/zoo.cfg"] ->
    Service["zookeeper"]
}