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

  Class["guardian"] ->
    Class["boxgrinder-repository"] ->
    Exec["boxgrinder libguestfs-tools"] ->
    Package["boxgrinder-build"]

}