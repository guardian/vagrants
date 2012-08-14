class 10gen-repository {

  if $operatingsystem != "ubuntu" {
    fail("Unsupported operating system: $operatingsystem")
  }

  if ($lsbdistcodename != "precise") {
    fail("Unsupported distribution: $lsbdistcodename")
  }

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/apt/sources.list.d": ensure => directory;

    "/etc/apt/sources.list.d/10gen-upstart.list":
      source => "puppet:///modules/mongodb/etc/apt/sources.list.d/10gen-upstart.list";

    "/etc/apt/trusted.gpg.d/10gen.gpg":
      source => "puppet:///modules/mongodb/etc/apt/trusted.gpg.d/10gen.gpg";
  }

  exec {
    "10gen apt-get update":
      command => "/usr/bin/apt-get update -y",
      subscribe => File[
        "/etc/apt/trusted.gpg.d/10gen.gpg",
        "/etc/apt/sources.list.d/10gen-upstart.list"
      ],
      refreshonly => true;
  }
}