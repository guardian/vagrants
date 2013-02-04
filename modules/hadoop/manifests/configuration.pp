# Hadoop configuration
class hadoop::configuration {

  file {
    '/etc/hadoop/hadoop-env.sh':
      source => 'puppet:///modules/hadoop/etc/hadoop/hadoop-env.sh',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/hadoop/core-site.xml':
      source => 'puppet:///modules/hadoop/etc/hadoop/core-site.xml',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/hadoop/hdfs-site.xml':
      source => 'puppet:///modules/hadoop/etc/hadoop/hdfs-site.xml',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/hadoop/mapred-site.xml':
      source => 'puppet:///modules/hadoop/etc/hadoop/mapred-site.xml',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/etc/init.d/hadoop':
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755';

    '/etc/init.d/hadoop/common':
      source => 'puppet:///modules/hadoop/etc/init.d/hadoop/common',
      owner  => root,
      group  => root,
      mode   => '4755';

    '/etc/init.d/hadoop/namenode':
      source => 'puppet:///modules/hadoop/etc/init.d/hadoop/namenode',
      owner  => root,
      group  => root,
      mode   => '4755';

    '/etc/init.d/hadoop/secondarynamenode':
      source => 'puppet:///modules/hadoop/etc/init.d/hadoop/secondarynamenode',
      owner  => root,
      group  => root,
      mode   => '4755';

    '/etc/init.d/hadoop/datanode':
      source => 'puppet:///modules/hadoop/etc/init.d/hadoop/datanode',
      owner  => root,
      group  => root,
      mode   => '4755';

    '/etc/init.d/hadoop/jobtracker':
      source => 'puppet:///modules/hadoop/etc/init.d/hadoop/jobtracker',
      owner  => root,
      group  => root,
      mode   => '4755';

    '/etc/init.d/hadoop/tasktracker':
      source => 'puppet:///modules/hadoop/etc/init.d/hadoop/tasktracker',
      owner  => root,
      group  => root,
      mode   => '4755';
  }
}