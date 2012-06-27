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