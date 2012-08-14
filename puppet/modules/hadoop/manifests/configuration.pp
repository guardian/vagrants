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

    "/etc/init.d/hadoop":
      ensure => directory,
      mode => 755;

    "/etc/init.d/hadoop/common":
      source => "puppet:///modules/hadoop/etc/init.d/hadoop/common",
      require => File["/etc/init.d/hadoop"],
      mode => 4755;

    "/etc/init.d/hadoop/namenode":
      source => "puppet:///modules/hadoop/etc/init.d/hadoop/namenode",
      require => File["/etc/init.d/hadoop"],
      mode => 4755;

    "/etc/init.d/hadoop/secondarynamenode":
      source => "puppet:///modules/hadoop/etc/init.d/hadoop/secondarynamenode",
      require => File["/etc/init.d/hadoop"],
      mode => 4755;

    "/etc/init.d/hadoop/datanode":
      source => "puppet:///modules/hadoop/etc/init.d/hadoop/datanode",
      require => File["/etc/init.d/hadoop"],
      mode => 4755;

    "/etc/init.d/hadoop/jobtracker":
      source => "puppet:///modules/hadoop/etc/init.d/hadoop/jobtracker",
      require => File["/etc/init.d/hadoop"],
      mode => 4755;

    "/etc/init.d/hadoop/tasktracker":
      source => "puppet:///modules/hadoop/etc/init.d/hadoop/tasktracker",
      require => File["/etc/init.d/hadoop"],
      mode => 4755;
  }
}