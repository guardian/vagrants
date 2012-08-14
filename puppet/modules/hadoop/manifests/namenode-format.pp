class namenode-format {

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
    provider => "init",
    hasstatus => true,
    ensure => running
  }

  service {
    "hadoop-namenode":
      start => "/etc/init.d/hadoop/namenode start",
      status => "/etc/init.d/hadoop/namenode status",
      stop => "/etc/init.d/hadoop/namenode stop";

    "hadoop-secondarynamenode":
      start => "/etc/init.d/hadoop/secondarynamenode start",
      status => "/etc/init.d/hadoop/secondarynamenode status",
      stop => "/etc/init.d/hadoop/secondarynamenode stop";

    "hadoop-datanode":
      start => "/etc/init.d/hadoop/datanode start",
      status => "/etc/init.d/hadoop/datanode status",
      stop => "/etc/init.d/hadoop/datanode stop";
  }

  exec {
    # Fix up file permissions inside HDFS
    "hdfs-root-permissions":
      command => "/usr/bin/hadoop --config /etc/hadoop fs -chmod 777 /",
      require => Service["hadoop-datanode"];
  }

  Exec["namenode-format"] ->
    File["/hadoop"] ->
    Service["hadoop-namenode"] ->
    Service["hadoop-secondarynamenode"] ->
    Service["hadoop-datanode"] ->
    Exec["hdfs-root-permissions"]
}