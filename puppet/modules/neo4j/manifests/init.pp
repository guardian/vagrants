class neo4j {

  include java
  include neo4j-user
  include neo4j-download
  include neo4j-configuration

  exec {
    neo4j-extract:
      cwd => "/usr/share",
      command => "/bin/tar xzf /var/cache/downloads/neo4j-community-1.7.2-unix.tar.gz && mv neo4j-community-1.7.2 neo4j",
      creates => "/usr/share/neo4j";
  }

  exec {
    neo4j-install:
      command => "/usr/share/neo4j/bin/neo4j -h install",
      refreshonly => true,
      subscribe => Exec["neo4j-extract"];
  }

  # The neo4j service doesn't listen to reason.
  exec {
    neo4j-start:
      command => "/usr/sbin/service neo4j-service restart",
      refreshonly => true,
      subscribe => Class["neo4j-configuration"];
  }

  service {
    neo4j-service: ensure => running;
  }

  Class["neo4j-user"] -> Exec["neo4j-install"]

  Class["java"] -> Exec["neo4j-install"]

  Class["neo4j-download"] ->
    Exec["neo4j-extract"] ->
    Exec["neo4j-install"] ->
    Class["neo4j-configuration"] ->
    Exec["neo4j-start"] ->
    Service["neo4j-service"]
}