class hive-download($url, $filename) {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/var/cache/downloads": ensure => directory;
  }

  exec {
    "download-hive":
      command => "/usr/bin/wget $url",
      cwd => "/var/cache/downloads",
      creates => "/var/cache/downloads/$filename",
      timeout => 0;
  }

  File["/var/cache/downloads"] -> Exec["download-hive"]
}