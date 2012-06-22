class elasticsearch inherits java {

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
      require => File["/var/cache/apt/archives"];
  }

  package {
    elasticsearch:
      provider => dpkg,
      ensure => installed,
      source => "/var/cache/apt/archives/elasticsearch-0.19.4.deb",
      require => Exec["download-elasticsearch-deb"];
  }

  file {
    "/etc/elasticsearch/elasticsearch.yml":
      source => "puppet:///modules/elasticsearch/etc/elasticsearch/elasticsearch.yml",
      subscribe => Package["elasticsearch"];
  }

  exec {
    "install-elasticsearch-plugin-head":
      command => "/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head",
      refreshonly => true,
      subscribe => Package["elasticsearch"];
  }

  exec {
    "install-elasticsearch-plugin-paramedic":
      command => "/usr/share/elasticsearch/bin/plugin -install karmi/elasticsearch-paramedic",
      refreshonly => true,
      subscribe => Package["elasticsearch"];
  }

  exec {
    "install-elasticsearch-plugin-bigdesk":
      command => "/usr/share/elasticsearch/bin/plugin -install lukas-vlcek/bigdesk",
      refreshonly => true,
      subscribe => Package["elasticsearch"];
  }

  service {
    elasticsearch:
      ensure => running,
      require => [
        Package["elasticsearch"],
        Exec[
          "install-elasticsearch-plugin-head",
          "install-elasticsearch-plugin-paramedic",
          "install-elasticsearch-plugin-bigdesk"
        ]
      ],
      subscribe => File["/etc/elasticsearch/elasticsearch.yml"];
  }
}