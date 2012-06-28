class init-replica-set {
 File {
    owner => root,
    group => root,
    mode => 755
  }

  file {
    "/opt/mongodb": ensure => directory;

    "/opt/mongodb/init-replica-set":
      require => File["/opt/mongodb"],
      source => "puppet:///files/opt/mongodb/init-replica-set";
  }

  exec {
    "mongo-init-replica-set":
      command => "/opt/mongodb/init-replica-set",
      creates => "/opt/mongodb/init-replica-set.done";
  }

  File["/opt/mongodb/init-replica-set"] -> Exec["mongo-init-replica-set"]
}