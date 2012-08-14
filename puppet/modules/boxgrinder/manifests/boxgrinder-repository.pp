class boxgrinder-repository {

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

    "/etc/apt/sources.list.d/boxgrinder.list":
      source => "puppet:///modules/boxgrinder/etc/apt/sources.list.d/boxgrinder.list";

    "/etc/apt/trusted.gpg.d/boxgrinder.gpg":
      source => "puppet:///modules/boxgrinder/etc/apt/trusted.gpg.d/boxgrinder.gpg";
  }

  exec {
    "boxgrinder apt-get update":
      command => "/usr/bin/apt-get update -y",
      subscribe => File[
        "/etc/apt/trusted.gpg.d/boxgrinder.gpg",
        "/etc/apt/sources.list.d/boxgrinder.list"
      ],
      refreshonly => true;
  }
}
