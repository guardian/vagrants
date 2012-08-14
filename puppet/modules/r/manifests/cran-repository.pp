class cran-repository {

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

    "/etc/apt/sources.list.d/cran.list":
      source => "puppet:///modules/r/etc/apt/sources.list.d/cran.list";

    "/etc/apt/trusted.gpg.d/cran.gpg":
      source => "puppet:///modules/r/etc/apt/trusted.gpg.d/cran.gpg";
  }

  exec {
    "cran apt-get update":
      command => "/usr/bin/apt-get update",
      subscribe => File[
        "/etc/apt/trusted.gpg.d/cran.gpg",
        "/etc/apt/sources.list.d/cran.list"
      ],
      refreshonly => true;
  }
}