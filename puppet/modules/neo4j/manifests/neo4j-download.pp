class neo4j-download {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/var/cache/downloads": ensure => directory;
  }

  exec {
    "download-neo4j":
      command => "/usr/bin/wget http://dist.neo4j.org/neo4j-community-1.7.2-unix.tar.gz",
      cwd => "/var/cache/downloads",
      creates => "/var/cache/downloads/neo4j-community-1.7.2-unix.tar.gz",
      timeout => 0;
  }

  File["/var/cache/downloads"] -> Exec["download-neo4j"]
}