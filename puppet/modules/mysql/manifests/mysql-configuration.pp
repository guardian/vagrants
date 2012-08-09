class mysql-configuration {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/mysql/my.cnf":
      source => "puppet:///modules/mysql/etc/mysql/my.cnf";
  }

}