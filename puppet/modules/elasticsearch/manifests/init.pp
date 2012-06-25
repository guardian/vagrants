class elasticsearch {

  include java
  include elasticsearch-download
  include elasticsearch-plugins

  package {
    elasticsearch:
      provider => dpkg,
      ensure => installed,
      source => "/var/cache/apt/archives/elasticsearch-0.19.4.deb";
  }

  service { elasticsearch: ensure => running; }

  Class["java"] -> Package["elasticsearch"]

  Class["elasticsearch-download"] ->
    Package["elasticsearch"] ->
    Class["elasticsearch-plugins"] ->
    Service["elasticsearch"]

}