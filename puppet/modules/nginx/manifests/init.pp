class nginx {

  include guardian
  include nginx-repository

  package { nginx: ensure => installed; }
  service { nginx: ensure => running; }

  Class["guardian"] ->
    Class["nginx-repository"] ->
    Package["nginx"] ->
    Service["nginx"]
}