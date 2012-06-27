class neo4j-configuration {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/usr/share/neo4j/conf/neo4j-server.properties":
      source => "puppet:///modules/neo4j/usr/share/neo4j/conf/neo4j-server.properties";
  }
}