class hive-configuration {

  service {
    "hive-hadoop-namenode":
      provider => "init",
      hasstatus => true,
      start => "/etc/init.d/hadoop/namenode start",
      status => "/etc/init.d/hadoop/namenode status",
      stop => "/etc/init.d/hadoop/namenode stop",
      ensure => running;

    "hive-hadoop-secondarynamenode":
      provider => "init",
      hasstatus => true,
      start => "/etc/init.d/hadoop/secondarynamenode start",
      status => "/etc/init.d/hadoop/secondarynamenode status",
      stop => "/etc/init.d/hadoop/secondarynamenode stop",
      ensure => running;

    "hive-hadoop-datanode":
      provider => "base",
      hasstatus => true,
      start => "/etc/init.d/hadoop/datanode start",
      status => "/etc/init.d/hadoop/datanode status",
      stop => "/etc/init.d/hadoop/datanode stop",
      ensure => running;
  }

  exec {
    "hdfs-mkdir-tmp":
      command => "/usr/bin/hadoop --config /etc/hadoop fs -test -e /tmp || /usr/bin/hadoop --config /etc/hadoop fs -mkdir /tmp";
  }

  exec {
    "hdfs-mkdir-hive-warehouse":
      command => "/usr/bin/hadoop --config /etc/hadoop fs -test -e /user/hive/warehouse || /usr/bin/hadoop --config /etc/hadoop fs -mkdir /user/hive/warehouse";
  }

  exec {
    "hdfs-permissions":
      command => "/usr/bin/hadoop --config /etc/hadoop fs -chmod a+w /tmp /user/hive/warehouse";
  }

  Service["hive-hadoop-namenode"] ->
    Service["hive-hadoop-secondarynamenode"] ->
    Service["hive-hadoop-datanode"] ->
    Exec["hdfs-mkdir-tmp"] ->
    Exec["hdfs-mkdir-hive-warehouse"] ->
    Exec["hdfs-permissions"]
}