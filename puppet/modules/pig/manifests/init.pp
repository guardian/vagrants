class pig {

  $download_url = 'http://mirror.ox.ac.uk/sites/rsync.apache.org/pig/pig-0.10.0/pig_0.10.0-1_i386.deb'
  $download_filename = 'pig_0.10.0-1_i386.deb'

  include guardian
  include java

  exec {
    "download-pig-deb":
      command => "/usr/bin/wget ${download_url}",
      cwd => "/var/cache/apt/archives",
      creates => "/var/cache/apt/archives/${download_filename}",
      timeout => 0;
  }

  package {
    pig:
      provider => dpkg,
      ensure => installed,
      source => "/var/cache/apt/archives/${download_filename}";
  }

  Class["guardian"] ->
    Class["java"] ->
    Exec["download-pig-deb"] ->
    Package["pig"]
}