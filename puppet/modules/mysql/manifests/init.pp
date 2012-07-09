class mysql {

  include guardian

  package {
    "mysql-server": ensure => installed;
    "mysql-client": ensure => installed;
  }
  service { mysql: ensure => running; }

  Class["guardian"] ->
    Package["mysql-server"] ->
    Service["mysql"]
}