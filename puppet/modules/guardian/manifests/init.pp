class guardian {

  if $operatingsystem != "ubuntu" {
    fail("Unsupported operating system: $operatingsystem")
  }

  if !($lsbdistcodename in ["lucid", "precise"]) {
    fail("Unsupported distribution: $lsbdistcodename")
  }

  group {
    "puppet": ensure => present;
  }

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/gu": ensure => directory;

    "/etc/gu/install_vars":
      source => "puppet:///modules/guardian/etc/gu/install_vars";

    # Use UK mirrors for Ubuntu repositories
    "/etc/apt/sources.list":
      source => "puppet:///modules/guardian/etc/apt/sources.list.$lsbdistcodename";

    # Need a long timeout for Postini download virus checks
    "/etc/apt/apt.conf.d/30timeout":
      source => "puppet:///modules/guardian/etc/apt/apt.conf.d/30timeout";

    "/etc/apt/apt.conf.d/31retries":
      source => "puppet:///modules/guardian/etc/apt/apt.conf.d/31retries";
  }

  exec {
    apt-update-sources:
      command => "/usr/bin/apt-get update",
      subscribe => File[
        "/etc/apt/sources.list",
        "/etc/apt/apt.conf.d/30timeout",
        "/etc/apt/apt.conf.d/31retries"
      ],
      refreshonly => true;
  }

  package {
    bash-completion:
     ensure => installed,
     require => Exec["apt-update-sources"];

    vim:
      ensure => installed,
      require => Exec["apt-update-sources"];
  }
}
