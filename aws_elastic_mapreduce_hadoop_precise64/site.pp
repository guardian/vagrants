node default {
  class { hadoop: hadoop_version => '0.20.205.0' }
  class { pig: pig_version => '0.9.2' }
  class { hive: hive_version => '0.8.1' }

  Class["hadoop"] -> Class["pig"]
  Class["hadoop"] -> Class["hive"]
}