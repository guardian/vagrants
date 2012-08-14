class hive {

  $download_url = 'http://mirror.ox.ac.uk/sites/rsync.apache.org/hive/hive-0.9.0/hive-0.9.0.tar.gz'
  $download_filename = 'hive-0.9.0.tar.gz'
  $download_extracted = 'hive-0.9.0'

  include guardian
  include java
  include hive-configuration

  file {
    "/etc/profile.d/hive.sh":
      source => "puppet:///modules/hive/etc/profile.d/hive.sh";
  }

  exec {
    "hive-download":
      command => "/usr/bin/wget $download_url",
      cwd => "/var/cache/downloads",
      creates => "/var/cache/downloads/$download_filename",
      timeout => 0;
  }

  exec {
    hive-extract:
      cwd => "/usr/share",
      command => "/bin/tar xzf /var/cache/downloads/$download_filename && mv $download_extracted hive",
      creates => "/usr/share/hive";
  }

  Class["guardian"] ->
    Class["java"] ->
    Exec["hive-download"] ->
    Exec["hive-extract"] ->
    Class["hive-configuration"]

}