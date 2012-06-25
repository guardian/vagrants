class mongodb {

  include 10gen-repository

  package { mongodb-10gen: ensure => installed; }
  service { mongodb: ensure => running; }

  Class["10gen-repository"] ->
    Package["mongodb-10gen"] ->
    Service["mongodb"]
}