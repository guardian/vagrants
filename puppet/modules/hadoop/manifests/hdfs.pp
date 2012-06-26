class hdfs {

  exec {
    "namenode-format":
      command => "/usr/bin/hadoop --config /etc/hadoop namenode -format",
      creates => "/hadoop/data";
  }

  file {
    # Fix up file permissions on base filesystem after namenode format
    "/hadoop":
      owner => hdfs,
      group => hdfs,
      recurse => true,
      subscribe => Exec["namenode-format"];
  }

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
      provider => "base",
      hasstatus => true,
      start => "/etc/init.d/hadoop/datanode start",
      status => "/etc/init.d/hadoop/datanode status",
      stop => "/etc/init.d/hadoop/datanode stop",
      ensure => running;
  }

  file {
    # Fix up log directory permissions after services start
    "/var/log/hadoop hdfs_permissions":
      path => "/var/log/hadoop",
      owner => root,
      group => root,
      mode => 777,
      recurse => true,
      subscribe => Service[
        "hadoop-namenode",
        "hadoop-secondarynamenode",
        "hadoop-datanode"
      ];
  }

  File["/hadoop"] ->
    Service["hadoop-namenode"] ->
    Service["hadoop-secondarynamenode"] ->
    Service["hadoop-datanode"] ->
    File["/var/log/hadoop hdfs_permissions"]

}