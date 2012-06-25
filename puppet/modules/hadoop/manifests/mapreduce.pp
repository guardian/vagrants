class mapreduce {

  exec {
    # Fix up file permissions inside HDFS
    "hdfs-root-permissions":
      command => "/usr/bin/hadoop --config /etc/hadoop fs -chmod 777 /",
      require => Service["hadoop-datanode"];
  }

  Service {
    require => Package["hadoop"],
    subscribe => Class["hdfs"]
  }

  service {
    "hadoop-jobtracker":
      provider => "base",
      start => "/usr/sbin/service hadoop-jobtracker start",
      status => "/bin/ps aux | /bin/grep 'org.apache.hadoop.mapred.JobTracker' | /bin/grep -v grep",
      stop => "/bin/kill `/bin/ps aux | /bin/grep 'org.apache.hadoop.mapred.JobTracker' | /bin/grep -v grep | /usr/bin/awk '{ print \$2 }'` && sleep 1",
      ensure => running;

    "hadoop-tasktracker":
      provider => "base",
      start => "/usr/sbin/service hadoop-tasktracker start",
      status => "/bin/ps aux | /bin/grep 'org.apache.hadoop.mapred.TaskTracker' | /bin/grep -v grep",
      stop => "/bin/kill `/bin/ps aux | /bin/grep 'org.apache.hadoop.mapred.TaskTracker' | /bin/grep -v grep | /usr/bin/awk '{ print \$2 }'` && sleep 1",
      ensure => running;
  }

  Exec["hdfs-root-permissions"] ->
    Service["hadoop-jobtracker"] ->
    Service["hadoop-tasktracker"]

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
}