class nginx {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/apt/sources.list.d": ensure => directory;

    "/etc/apt/sources.list.d/nginx-$lsbdistcodename.list":
      source => "puppet:///modules/nginx/etc/apt/sources.list.d/nginx-$lsbdistcodename.list";

    "/etc/apt/trusted.gpg.d/nginx.gpg":
      source => "puppet:///modules/nginx/etc/apt/trusted.gpg.d/nginx.gpg";

    "/etc/nginx/sites-available":
      ensure => directory,
      purge => true;

    "/etc/nginx/sites-enabled":
      ensure => directory,
      purge => true;
  }

  exec {
    apt-add-nginx-key:
      command => "/usr/bin/apt-get update",
      subscribe => File["/etc/apt/trusted.gpg.d/nginx.gpg"],
      refreshonly => true;
  }

  package {
    nginx:
      ensure => installed,
      require => [
        File["/etc/apt/sources.list.d/nginx-$lsbdistcodename.list"],
        Exec["apt-add-nginx-key"]
      ];
  }

  service {
    nginx:
      ensure => running,
      require => Package["nginx"];
  }
}
