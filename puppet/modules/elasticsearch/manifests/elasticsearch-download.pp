class elasticsearch-download {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/var/cache/apt/archives": ensure => directory;
  }

  exec {
    "download-elasticsearch-deb":
      command => "/usr/bin/wget https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-0.19.4.deb",
      cwd => "/var/cache/apt/archives",
      creates => "/var/cache/apt/archives/elasticsearch-0.19.4.deb",
      timeout => 0;
  }

  File["/var/cache/apt/archives"] -> Exec["download-elasticsearch-deb"]
}