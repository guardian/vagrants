class nginx-repository {

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

    "/etc/apt/sources.list.d/nginx-precise.list":
      source => "puppet:///modules/nginx/etc/apt/sources.list.d/nginx-precise.list";

    "/etc/apt/trusted.gpg.d/nginx.gpg":
      source => "puppet:///modules/nginx/etc/apt/trusted.gpg.d/nginx.gpg";
  }

  exec {
    "nginx apt-get update":
      command => "/usr/bin/apt-get update",
      subscribe => File[
        "/etc/apt/trusted.gpg.d/nginx.gpg",
        "/etc/apt/sources.list.d/nginx-precise.list"
      ],
      refreshonly => true;
  }
}