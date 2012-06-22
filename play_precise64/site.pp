node default {

  include nginx

  file {
    "/etc/nginx/conf.d/default.conf":
      ensure => absent,
      require => Package[nginx],
      notify => Service[nginx];

    "/etc/nginx/conf.d/example_ssl.conf":
      ensure => absent,
      require => Package[nginx],
      notify => Service[nginx];

    "/etc/nginx/conf.d/frontend.conf":
      source => 'puppet:///files/etc/nginx/conf.d/frontend.conf',
      require => Package[nginx],
      notify => Service[nginx];
  }
}