# Manage a Hadoop installation matching AWS Elastic MapReduce
class hadoop {

  require java
  include configuration
  include pig
  include hive

  $url ='http://mirror.ox.ac.uk/sites/rsync.apache.org/hadoop/common/hadoop-1.0.4'
  $filename ='hadoop_1.0.4-1_x86_64.deb'

  exec {
    'download-hadoop':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      timeout => 0;
  }

  package {
    'hadoop':
      ensure   => installed,
      provider => dpkg,
      source   => "/root/${filename}";
  }

  file {
    '/root/hdfs.setup':
      source => 'puppet:///modules/hadoop/root/hdfs.setup',
      owner  => root,
      group  => root,
      mode   => '0744';
  }

  exec {
    'setup-hdfs':
      cwd     => '/root',
      command => '/root/hdfs.setup',
      creates => '/root/hdfs.done';
  }

  File['/root/hdfs.setup'] -> Exec['setup-hdfs']

  Exec['download-hadoop'] ->
    Package['hadoop'] ->
    Class['configuration'] ->
    Exec['setup-hdfs']

  Exec['setup-hdfs'] -> Class['pig']
  Exec['setup-hdfs'] -> Class['hive']
}