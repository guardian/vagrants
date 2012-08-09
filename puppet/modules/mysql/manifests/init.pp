class mysql {

  include guardian
  include mysql-configuration

  package {
    "mysql-server": ensure => installed;
    "mysql-client": ensure => installed;
  }

  service {
    mysql:
      ensure => running,
      subscribe => Class["mysql-configuration"];
  }

  exec {
    mysql-relax-connection-permissions:
      command => "/usr/bin/mysql -u root -e \"grant all privileges on *.* to 'root'@'%';\"";
  }

  Class["guardian"] ->
    Package["mysql-server"] ->
    Class["mysql-configuration"] ->
    Service["mysql"] ->
    Exec["mysql-relax-connection-permissions"]
}