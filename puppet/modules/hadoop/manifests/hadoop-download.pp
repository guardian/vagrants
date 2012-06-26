class hadoop-download {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/var/cache/apt/archives": ensure => directory;
  }

  exec {
    "download-hadoop-deb":
      command => "/usr/bin/wget http://mirror.ox.ac.uk/sites/rsync.apache.org/hadoop/common/hadoop-1.0.3/hadoop_1.0.3-1_x86_64.deb",
      cwd => "/var/cache/apt/archives",
      creates => "/var/cache/apt/archives/hadoop_1.0.3-1_x86_64.deb",
      timeout => 0;
  }

  File["/var/cache/apt/archives"] -> Exec["download-hadoop-deb"]
}