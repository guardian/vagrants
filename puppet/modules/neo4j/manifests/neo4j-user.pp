class neo4j-user {

  user {
    neo4j:
      comment => "Neo4J daemon user",
      ensure => present;
  }

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    # ulimit -n 65536 for neo4j
    "/etc/security/limits.conf":
      source => "puppet:///modules/neo4j/etc/security/limits.conf";
  }
}