node default {

  package { nginx: ensure => latest; }
  service { nginx: ensure => running; }

  Package["nginx"] -> Service["nginx"]

  file {
    "/etc/nginx/conf.d/default.conf":
      ensure => absent,
      require => Package[nginx],
      notify => Service[nginx];

    "/etc/nginx/conf.d/example_ssl.conf":
      ensure => absent,
      require => Package[nginx],
      notify => Service[nginx];

    "/etc/nginx/conf.d/play_appserver.conf":
      source => 'puppet:///files/etc/nginx/conf.d/play_appserver.conf',
      require => Package[nginx],
      notify => Service[nginx];
  }
}