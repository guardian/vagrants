node default {

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

  Service["hadoop-namenode"] ->
    Service["hadoop-secondarynamenode"] ->
    Service["hadoop-datanode"] ->
    Service["hadoop-jobtracker"] ->
    Service["hadoop-tasktracker"]
}