class hdfs {

  exec {
    "namenode-format":
      command => "/usr/bin/hadoop --config /etc/hadoop namenode -format",
      creates => "/hadoop/data";
  }

  file {
    # Fix up file permissions on base filesystem after namenode format
    "/hadoop":
      owner => root,
      group => root,
      mode => 777,
      recurse => true,
      subscribe => Exec["namenode-format"];
  }

  Service {
    require => File["/hadoop"],
    subscribe => Class["configuration"]
  }

  service {
    "hadoop-namenode":
      provider => "base",
      start => "/usr/sbin/service hadoop-namenode start",
      status => "/bin/ps aux | /bin/grep 'org.apache.hadoop.hdfs.server.namenode.NameNode' | /bin/grep -v grep",
      stop => "/bin/kill `/bin/ps aux | /bin/grep 'org.apache.hadoop.hdfs.server.namenode.NameNode' | /bin/grep -v grep | /usr/bin/awk '{ print \$2 }'` && sleep 1",
      ensure => running;

    "hadoop-secondarynamenode":
      provider => "base",
      start => "/usr/sbin/service hadoop-secondarynamenode start",
      status => "/bin/ps aux | /bin/grep 'org.apache.hadoop.hdfs.server.namenode.SecondaryNameNode' | /bin/grep -v grep",
      stop => "/bin/kill `/bin/ps aux | /bin/grep 'org.apache.hadoop.hdfs.server.namenode.SecondaryNameNode' | /bin/grep -v grep | /usr/bin/awk '{ print \$2 }'` && sleep 1",
      ensure => running;

    "hadoop-datanode":
      provider => "base",
      start => "/usr/sbin/service hadoop-datanode start",
      status => "/bin/ps aux | /bin/grep 'org.apache.hadoop.hdfs.server.datanode.DataNode' | /bin/grep -v grep",
      stop => "/bin/kill `/bin/ps aux | /bin/grep 'org.apache.hadoop.hdfs.server.datanode.DataNode' | /bin/grep -v grep | /usr/bin/awk '{ print \$2 }'` && sleep 1",
      ensure => running;
  }

  Service["hadoop-namenode"] ->
    Service["hadoop-secondarynamenode"] ->
    Service["hadoop-datanode"]

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

}