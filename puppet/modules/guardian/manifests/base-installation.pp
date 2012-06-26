class base-installation {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/gu": ensure => directory;

    "/etc/gu/install_vars":
      source => "puppet:///modules/guardian/etc/gu/install_vars";
  }
}