class elasticsearch {

  include guardian
  include java
  include elasticsearch-plugins

  exec {
    "download-elasticsearch-deb":
      command => "/usr/bin/wget https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-0.19.4.deb",
      cwd => "/var/cache/apt/archives",
      creates => "/var/cache/apt/archives/elasticsearch-0.19.4.deb",
      timeout => 0;
  }

  package {
    elasticsearch:
      provider => dpkg,
      ensure => installed,
      source => "/var/cache/apt/archives/elasticsearch-0.19.4.deb";
  }

  service { elasticsearch: ensure => running; }

  Class["java"] -> Package["elasticsearch"]

  Class["guardian"] ->
    Exec["download-elasticsearch-deb"] ->
    Package["elasticsearch"] ->
    Class["elasticsearch-plugins"] ->
    Service["elasticsearch"]

}