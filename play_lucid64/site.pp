node default {

  include nginx

  file {
    "/etc/nginx/conf.d/default.conf":
      ensure => absent,
      notify => Service[nginx];

    "/etc/nginx/conf.d/example_ssl.conf":
      ensure => absent,
      notify => Service[nginx];

    "/etc/nginx/conf.d/frontend.conf":
      source => 'puppet:///files/etc/nginx/conf.d/frontend.conf',
      notify => Service[nginx];
  }
}