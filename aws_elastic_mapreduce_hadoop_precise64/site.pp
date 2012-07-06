node default {
  class { 'hadoop': hadoop_version => '0.20.205.0' }
  class { 'pig': pig_version => '0.9.2' }

  Class["hadoop"] -> Class["pig"]
}