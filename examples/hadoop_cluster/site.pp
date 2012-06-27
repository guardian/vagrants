class configuration {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/hosts":
      source => "puppet:///files/etc/hosts";

    "/etc/hadoop/core-site.xml":
      source => "puppet:///files/etc/hadoop/core-site.xml";

    "/etc/hadoop/hdfs-site.xml":
      source => "puppet:///files/etc/hadoop/hdfs-site.xml";

    "/etc/hadoop/mapred-site.xml":
      source => "puppet:///files/etc/hadoop/mapred-site.xml";

    "/etc/hadoop/masters":
      source => "puppet:///files/etc/hadoop/masters";

    "/etc/hadoop/slaves":
      source => "puppet:///files/etc/hadoop/slaves";
  }

}

node master {

  include configuration

  Service {
    subscribe => Class["configuration"]
  }

  service {
    "hadoop-namenode":
      provider => "init",
      hasstatus => true,
      start => "/etc/init.d/hadoop/namenode start",
      status => "/etc/init.d/hadoop/namenode status",
      stop => "/etc/init.d/hadoop/namenode stop",
      ensure => running;

    "hadoop-secondarynamenode":
      provider => "init",
      hasstatus => true,
      start => "/etc/init.d/hadoop/secondarynamenode start",
      status => "/etc/init.d/hadoop/secondarynamenode status",
      stop => "/etc/init.d/hadoop/secondarynamenode stop",
      ensure => running;

    "hadoop-datanode":
      provider => "init",
      hasstatus => true,
      start => "/etc/init.d/hadoop/datanode start",
      status => "/etc/init.d/hadoop/datanode status",
      stop => "/etc/init.d/hadoop/datanode stop",
      ensure => running;

    "hadoop-jobtracker":
      provider => "init",
      hasstatus => true,
      start => "/etc/init.d/hadoop/jobtracker start",
      status => "/etc/init.d/hadoop/jobtracker status",
      stop => "/etc/init.d/hadoop/jobtracker stop",
      ensure => running;

    "hadoop-tasktracker":
      provider => "init",
      hasstatus => true,
      start => "/etc/init.d/hadoop/tasktracker start",
      status => "/etc/init.d/hadoop/tasktracker status",
      stop => "/etc/init.d/hadoop/tasktracker stop",
      ensure => running;
  }

  Class["configuration"] ->
    Service["hadoop-namenode"] ->
    Service["hadoop-secondarynamenode"] ->
    Service["hadoop-datanode"] ->
    Service["hadoop-jobtracker"] ->
    Service["hadoop-tasktracker"]
}

node slave1,slave2 {

  include configuration

  # Purge datanode material from base box
  file {
    "/tmp/hadoop-hdfs": ensure => absent;
    "/hadoop": ensure => absent;
  }

  Service {
    subscribe => Class["configuration"]
  }

  service {
    "hadoop-datanode":
      provider => "init",
      hasstatus => true,
      start => "/etc/init.d/hadoop/datanode start",
      status => "/etc/init.d/hadoop/datanode status",
      stop => "/etc/init.d/hadoop/datanode stop",
      ensure => running;

    "hadoop-tasktracker":
      provider => "init",
      hasstatus => true,
      start => "/etc/init.d/hadoop/tasktracker start",
      status => "/etc/init.d/hadoop/tasktracker status",
      stop => "/etc/init.d/hadoop/tasktracker stop",
      ensure => running;
  }

  Class["configuration"] ->
    File["/tmp/hadoop-hdfs", "/hadoop"] ->
    Service["hadoop-datanode"] ->
    Service["hadoop-tasktracker"]
}