class mapreduce {

  exec {
    # Fix up file permissions inside HDFS
    "hdfs-root-permissions":
      command => "/usr/bin/hadoop --config /etc/hadoop fs -chmod 777 /",
      require => Service["hadoop-datanode"];
  }

  Service {
    subscribe => Class["configuration"]
  }

  service {
    "hadoop-jobtracker":
      provider => "base",
      hasstatus => true,
      start => "/etc/init.d/hadoop/jobtracker start",
      status => "/etc/init.d/hadoop/jobtracker status",
      stop => "/etc/init.d/hadoop/jobtracker stop",
      ensure => running;

    "hadoop-tasktracker":
      provider => "base",
      hasstatus => true,
      start => "/etc/init.d/hadoop/tasktracker start",
      status => "/etc/init.d/hadoop/tasktracker status",
      stop => "/etc/init.d/hadoop/tasktracker stop",
      ensure => running;
  }

  file {
    # Fix up log directory permissions after services start
    "/var/log/hadoop mapreduce_permissions":
      owner => root,
      group => root,
      mode => 777,
      recurse => true,
      subscribe => Service[
        "hadoop-jobtracker",
        "hadoop-tasktracker"
      ];
  }

  Exec["hdfs-root-permissions"] ->
    Service["hadoop-jobtracker"] ->
    Service["hadoop-tasktracker"] ->
    File["/var/log/hadoop mapreduce_permissions"]
}