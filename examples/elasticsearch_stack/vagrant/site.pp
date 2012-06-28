node default {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/hosts":
      source => "puppet:///files/etc/hosts";
  }

}