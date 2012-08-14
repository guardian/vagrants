node default {
  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    # Use UK mirrors for Ubuntu repositories
    "/etc/apt/sources.list":
      source => "puppet:///files/etc/apt/sources.list";

    # Need a long timeout for download virus checks
    "/etc/apt/apt.conf.d/30timeout":
      source => "puppet:///files/etc/apt/apt.conf.d/30timeout";

    "/etc/apt/apt.conf.d/31retries":
      source => "puppet:///files/etc/apt/apt.conf.d/31retries";

    # Boxgrinder repository
    "/etc/apt/sources.list.d/boxgrinder.list":
      source => "puppet:///files/etc/apt/sources.list.d/boxgrinder.list";

    "/etc/apt/trusted.gpg.d/boxgrinder.gpg":
      source => "puppet:///files/etc/apt/trusted.gpg.d/boxgrinder.gpg";
  }

  exec {
    "apt-get update":
      command => "/usr/bin/apt-get update -y",
      subscribe => File[
        "/etc/apt/sources.list",
        "/etc/apt/sources.list.d/boxgrinder.list",
        "/etc/apt/trusted.gpg.d/boxgrinder.gpg"
      ],
      refreshonly => true;
  }

  exec { "apt-get upgrade":
    command => "/usr/bin/apt-get upgrade -y"
  }

  package {
    boxgrinder-build: ensure => latest;
  }

  File["/etc/apt/apt.conf.d/30timeout", "/etc/apt/apt.conf.d/31retries"] ->
    Exec["apt-get update"]

  Exec["apt-get update"] -> Exec["apt-get upgrade"]

  Exec["apt-get update"] ->
    Package["boxgrinder-build"]
}
