class apt {
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
    # Use UK mirrors for Ubuntu repositories
    "/etc/apt/sources.list":
      source => "puppet:///modules/guardian/etc/apt/sources.list";

    # Need a long timeout for download virus checks
    "/etc/apt/apt.conf.d/30timeout":
      source => "puppet:///modules/guardian/etc/apt/apt.conf.d/30timeout";

    "/etc/apt/apt.conf.d/31retries":
      source => "puppet:///modules/guardian/etc/apt/apt.conf.d/31retries";

    "/var/cache/apt/archives": ensure => directory;
  }

  exec {
    "apt-update":
      command => "/usr/bin/apt-get update -y",
      subscribe => File["/etc/apt/sources.list", "/etc/apt/apt.conf.d/30timeout", "/etc/apt/apt.conf.d/31retries"],
      refreshonly => true;
  }

  File["/etc/apt/sources.list", "/etc/apt/apt.conf.d/30timeout", "/etc/apt/apt.conf.d/31retries"] ->
    Exec["apt-update"]
}