class nginx {

  include nginx-repository

  package { nginx: ensure => installed; }
  service { nginx: ensure => running; }

  Class["nginx-repository"] ->
    Package["nginx"] ->
    Service["nginx"]
}