class mongodb {

  include guardian
  include 10gen-repository

  package { mongodb-10gen: ensure => latest; }
  service { mongodb: ensure => running; }

  Class["guardian"] ->
    Class["10gen-repository"] ->
    Package["mongodb-10gen"] ->
    Service["mongodb"]
}