class hadoop {

  if $operatingsystem != "ubuntu" {
    fail("Unsupported operating system: $operatingsystem")
  }

  if ($lsbdistcodename != "precise") {
    fail("Unsupported distribution: $lsbdistcodename")
  }

  include java
  include hadoop-download
  include configuration
  include namenode-format

  package {
    hadoop:
      provider => dpkg,
      ensure => installed,
      source => "/var/cache/apt/archives/hadoop_1.0.3-1_x86_64.deb";
  }

  Class["java"] -> Package["hadoop"]

  Class["hadoop-download"] ->
    Package["hadoop"] ->
    Class["configuration"] ->
    Class["namenode-format"]
}