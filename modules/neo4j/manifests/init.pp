# Manage a Neo4J installation
class neo4j {

  require java

  $url = 'http://dist.neo4j.org'
  $filename = 'neo4j-community-1.8.1-unix.tar.gz'
  $extracted = 'neo4j-community-1.8.1'

  user {
    'neo4j':
      ensure  => present,
      comment => 'Neo4J daemon user';
  }

  exec {
    'download-neo4j':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      timeout => 0;

    'extract-neo4j':
      cwd     => '/usr/share',
      command => "/bin/tar xzf /root/${filename} && mv ${extracted} neo4j",
      creates => '/usr/share/neo4j';

    'install-neo4j':
      command     => '/usr/share/neo4j/bin/neo4j -h install',
      refreshonly => true,
      subscribe   => Exec['extract-neo4j'];

    # The neo4j service won't listen to reason.
    'start-neo4j': command => '/usr/sbin/service neo4j-service restart';
  }

  file {
    '/usr/share/neo4j/conf/neo4j-server.properties':
      source => 'puppet:///modules/neo4j/usr/share/neo4j/conf/neo4j-server.properties',
      owner  => root,
      group  => root,
      mode   => '0644';

    # ulimit -n 65536 for neo4j
    '/etc/security/limits.conf':
      source => 'puppet:///modules/neo4j/etc/security/limits.conf',
      owner  => root,
      group  => root,
      mode   => '0644';
  }

  Exec['download-neo4j'] ->
    Exec['extract-neo4j'] ->
    File['/etc/security/limits.conf'] ->
    User['neo4j'] ->
    Exec['install-neo4j'] ->
    File['/usr/share/neo4j/conf/neo4j-server.properties'] ->
    Exec['start-neo4j']
}