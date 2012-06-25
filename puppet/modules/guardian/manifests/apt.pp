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

    # Need a long timeout for Postini download virus checks
    "/etc/apt/apt.conf.d/30timeout":
      source => "puppet:///modules/guardian/etc/apt/apt.conf.d/30timeout";

    "/etc/apt/apt.conf.d/31retries":
      source => "puppet:///modules/guardian/etc/apt/apt.conf.d/31retries";
  }

  exec {
    apt-update-sources:
      command => "/usr/bin/apt-get update",
      require => File[
        "/etc/apt/apt.conf.d/30timeout",
        "/etc/apt/apt.conf.d/31retries"
      ],
      subscribe => File["/etc/apt/sources.list"],
      refreshonly => true;
  }
}