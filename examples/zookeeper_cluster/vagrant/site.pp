node default {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/hosts": source => "puppet:///files/etc/hosts";

    "/etc/zookeeper/conf": ensure => directory;

    "/etc/zookeeper/conf/zoo.cfg":
      require => File["/etc/zookeeper/conf"],
      source => "puppet:///files/etc/zookeeper/conf/zoo.cfg";

    "/etc/zookeeper/conf/environment":
      require => File["/etc/zookeeper/conf"],
      source => "puppet:///files/etc/zookeeper/conf/environment";

    "/etc/zookeeper/conf/log4j.properties":
      require => File["/etc/zookeeper/conf"],
      source => "puppet:///files/etc/zookeeper/conf/log4j.properties";

    "/etc/zookeeper/conf/myid":
      require => File["/etc/zookeeper/conf"],
      content => template("myid.erb");
  }

  service {
    zookeeper:
      ensure => running,
      subscribe => File[
        "/etc/zookeeper/conf",
        "/etc/zookeeper/conf/zoo.cfg",
        "/etc/zookeeper/conf/environment",
        "/etc/zookeeper/conf/log4j.properties",
        "/etc/zookeeper/conf/myid"
      ];
  }

  File[
    "/etc/hosts",
    "/etc/zookeeper/conf",
    "/etc/zookeeper/conf/zoo.cfg",
    "/etc/zookeeper/conf/environment",
    "/etc/zookeeper/conf/log4j.properties",
    "/etc/zookeeper/conf/myid"
  ] ->
    Service["zookeeper"]
}