class configuration {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/hadoop/hadoop-env.sh":
      source => "puppet:///modules/hadoop/etc/hadoop/hadoop-env.sh",
      subscribe => Package["hadoop"];

    "/etc/hadoop/core-site.xml":
      source => "puppet:///modules/hadoop/etc/hadoop/core-site.xml",
      subscribe => Package["hadoop"];

    "/etc/hadoop/hdfs-site.xml":
      source => "puppet:///modules/hadoop/etc/hadoop/hdfs-site.xml",
      subscribe => Package["hadoop"];

    "/etc/hadoop/mapred-site.xml":
      source => "puppet:///modules/hadoop/etc/hadoop/mapred-site.xml",
      subscribe => Package["hadoop"];
  }

}