class hadoop {

  if $operatingsystem != "ubuntu" {
    fail("Unsupported operating system: $operatingsystem")
  }

  if ($lsbdistcodename != "precise") {
    fail("Unsupported distribution: $lsbdistcodename")
  }

  $download_url ='http://mirror.ox.ac.uk/sites/rsync.apache.org/hadoop/common/hadoop-1.0.3/hadoop_1.0.3-1_x86_64.deb'
  $download_filename ='hadoop_1.0.3-1_x86_64.deb'

  include guardian
  include java
  include configuration
  include namenode-format

  exec {
    "download-hadoop-deb":
      command => "/usr/bin/wget ${download_url}",
      cwd => "/var/cache/apt/archives",
      creates => "/var/cache/apt/archives/${download_filename}",
      timeout => 0;
  }

  package {
    hadoop:
      provider => dpkg,
      ensure => installed,
      source => "/var/cache/apt/archives/${download_filename}";
  }

  Class["java"] -> Package["hadoop"]

  Class["guardian"] ->
    Exec["download-hadoop-deb"] ->
    Package["hadoop"] ->
    Class["configuration"] ->
    Class["namenode-format"]
}