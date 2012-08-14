class boxgrinder {

  include guardian
  include boxgrinder-repository

  exec {
    "boxgrinder libguestfs-tools":
      environment => "DEBIAN_FRONTEND=noninteractive",
      command => "/usr/bin/apt-get -q -y -o DPkg::Options::=--force-confold install libguestfs-tools";
  }

  package {
    boxgrinder-build: ensure => latest;
  }

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/vmbuilder/firstscripts/apt.sh":
      source => "puppet:///modules/boxgrinder/etc/vmbuilder/firstscripts/apt.sh";

    "/etc/vmbuilder.cfg":
      source => "puppet:///modules/boxgrinder/etc/vmbuilder.cfg";
  }

  Class["guardian"] ->
    Class["boxgrinder-repository"] ->
    Exec["boxgrinder libguestfs-tools"] ->
    Package["boxgrinder-build"] ->
    File["/etc/vmbuilder/firstscripts/apt.sh"]

}