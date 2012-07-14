class flume {

  include guardian
  include java

  file {
    "/etc/profile.d/flume-ng.sh":
      source => "puppet:///modules/flume/etc/profile.d/flume-ng.sh";

    "/etc/flume-ng": ensure => directory;

    "/etc/flume-ng/flume.conf":
      source => "puppet:///modules/flume/etc/flume-ng/flume.conf",
      require => File["/etc/flume-ng"];

    "/etc/flume-ng/flume-env.sh":
      source => "puppet:///modules/flume/etc/flume-ng/flume-env.sh",
      require => File["/etc/flume-ng"];
  }

  exec {
    "flume-download":
      command => "/usr/bin/wget http://mirror.ox.ac.uk/sites/rsync.apache.org/incubator/flume/flume-1.1.0-incubating/apache-flume-1.1.0-incubating-bin.tar.gz",
      cwd => "/var/cache/downloads",
      creates => "/var/cache/downloads/apache-flume-1.1.0-incubating-bin.tar.gz",
      timeout => 0;
  }

  exec {
    flume-extract:
      cwd => "/usr/share",
      command => "/bin/tar xzf /var/cache/downloads/apache-flume-1.1.0-incubating-bin.tar.gz && mv apache-flume-1.1.0-incubating-bin flume-ng",
      creates => "/usr/share/flume-ng";
  }

  Class["guardian"] ->
    Class["java"] ->
    Exec["flume-download"] ->
    Exec["flume-extract"]

}
