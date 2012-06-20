class elasticsearch inherits java {

  file {
    '/var/cache/apt/archives': ensure => directory;
  }

  exec {
    'download-elasticsearch-deb':
      command => '/usr/bin/wget https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-0.19.4.deb',
      cwd => '/var/cache/apt/archives',
      creates => '/var/cache/apt/archives/elasticsearch-0.19.4.deb',
      require => File['/var/cache/apt/archives'];
  }

  package {
    elasticsearch:
      provider => dpkg,
      ensure => installed,
      source => '/var/cache/apt/archives/elasticsearch-0.19.4.deb',
      require => Exec['download-elasticsearch-deb'];
  }

  service {
    elasticsearch:
      ensure => running,
      require => Package['elasticsearch'];
  }
}