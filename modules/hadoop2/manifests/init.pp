# Hadoop BigTop Infinite Intern
class hadoop2 {

  require java

  $repo = 'http://bigtop.s3.amazonaws.com/releases/0.4.0'
  $arch = 'ubuntu/precise/x86_64'

  apt::source {
    'bigtop':
      # TODO: bigtop-0.5.0 not present on S3?
      location    => "${repo}/${arch}",
      release     => 'bigtop',
      repos       => 'contrib',
      key         => '9475BD5D',
      key_server  => 'keyserver.ubuntu.com',
      include_src => false;
  }

  file {
    '/root/hdfs.setup':
      source => 'puppet:///modules/hadoop2/root/hdfs.setup',
      owner  => root,
      group  => root,
      mode   => '0744';

    # TODO: Remove, fixed in bigtop-0.5.0
    '/etc/hue/conf/hue.ini':
      source => 'puppet:///modules/hadoop2/etc/hue/conf/hue.ini',
      owner  => root,
      group  => root,
      mode   => '0744';
  }

  package {
    [
      'bigtop-utils',
      'hadoop-conf-pseudo',
      'oozie',
      'hue',
      'hive',
      'pig',
      'zookeeper-server',
      'giraph',
      'heimdal-clients'
    ]: ensure => latest;
  }

  exec {
    'setup-namenode':
      command => '/etc/init.d/hadoop-hdfs-namenode init',
      creates => '/var/lib/hadoop-hdfs/cache/hdfs/dfs/data';

    'download-extjs':
      cwd     => '/usr/lib/oozie/libext',
      command => '/usr/bin/wget http://extjs.com/deploy/ext-2.2.zip',
      creates => '/usr/lib/oozie/libext/ext-2.2.zip';

    'setup-oozie':
      command => '/etc/init.d/oozie init && touch /root/oozie.done',
      creates => '/root/oozie.done';

    'setup-hdfs':
      cwd     => '/root',
      command => '/root/hdfs.setup',
      creates => '/root/hdfs.done';
  }

  service {
    [
      'hadoop-hdfs-namenode',
      'hadoop-hdfs-datanode',
      'hadoop-yarn-resourcemanager',
      'hadoop-yarn-nodemanager',
      'hadoop-mapreduce-historyserver',
      'oozie',
      'hue',
      'zookeeper-server'
    ]:
      ensure => running,
      enable => true;
  }

  Apt::Source['bigtop'] ->
    Package['bigtop-utils'] ->
    Package['hadoop-conf-pseudo'] ->
    Exec['setup-namenode'] ->
    Service['hadoop-hdfs-namenode'] ->
    Service['hadoop-hdfs-datanode'] ->
    Exec['setup-hdfs'] ->
    Service['hadoop-yarn-resourcemanager'] ->
    Service['hadoop-yarn-nodemanager'] ->
    Service['hadoop-mapreduce-historyserver']

  Service['hadoop-mapreduce-historyserver'] ->
    Package['oozie'] ->
    Exec['download-extjs'] ->
    Exec['setup-oozie'] ->
    Service['oozie']

  Service['hadoop-mapreduce-historyserver'] ->
    Package['hue'] ->
    File['/etc/hue/conf/hue.ini'] ->
    Service['hue']

  Service['hadoop-mapreduce-historyserver'] -> Package['giraph']
  Service['hadoop-mapreduce-historyserver'] -> Package['pig']
  Service['hadoop-mapreduce-historyserver'] -> Package['hive']

  Package['bigtop-utils'] ->
    Package['zookeeper-server'] ->
    Service['zookeeper-server']
}
