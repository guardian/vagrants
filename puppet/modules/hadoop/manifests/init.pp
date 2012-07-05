class hadoop($hadoop_version = '1.0.3') {

  if $operatingsystem != "ubuntu" {
    fail("Unsupported operating system: $operatingsystem")
  }

  if ($lsbdistcodename != "precise") {
    fail("Unsupported distribution: $lsbdistcodename")
  }

  $hadoop_distributions = {
    '0.20.205.0' => {
      'url' => 'http://mirror.ox.ac.uk/sites/rsync.apache.org/hadoop/common/hadoop-0.20.205.0/hadoop_0.20.205.0-1_i386.deb',
      'filename' => 'hadoop_0.20.205.0-1_i386.deb'
    },
    '1.0.3' => {
      'url' => 'http://mirror.ox.ac.uk/sites/rsync.apache.org/hadoop/common/hadoop-1.0.3/hadoop_1.0.3-1_x86_64.deb',
      'filename' => 'hadoop_1.0.3-1_x86_64.deb'
    }
  }

  $download_url = $hadoop_distributions[$hadoop_version]['url']
  $download_filename = $hadoop_distributions[$hadoop_version]['filename']

  if (!$download_url) {
    fail("Unsupported Hadoop distribution: ${hadoop_version}")
  }

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