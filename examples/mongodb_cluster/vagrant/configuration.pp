class configuration {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/hosts":
      source => "puppet:///files/etc/hosts";

    "/etc/mongodb.conf":
      source => "puppet:///files/etc/mongodb.conf";
  }

  service {
    mongodb:
      ensure => running,
      subscribe => File["/etc/mongodb.conf"];
  }

  File["/etc/mongodb.conf"] -> Service["mongodb"]
}