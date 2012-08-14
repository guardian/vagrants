node default {

  package { apache2: ensure => latest; }
  service { apache2: ensure => running; }

  Package["apache2"] -> Service["apache2"]

  file {
    "/etc/apache2/sites-enabled/000-default":
      ensure => absent,
      require => Package[apache2],
      notify => Service[apache2];

    "/etc/apache2/sites-enabled/play_appserver":
      source => 'puppet:///files/etc/apache2/sites-enabled/play_appserver',
      require => Package[apache2],
      notify => Service[apache2];

    "/etc/apache2/mods-enabled/proxy.load":
      source => 'puppet:///files/etc/apache2/mods-enabled/proxy.load',
      require => Package[apache2],
      notify => Service[apache2];

    "/etc/apache2/mods-enabled/proxy_http.load":
      source => 'puppet:///files/etc/apache2/mods-enabled/proxy_http.load',
      require => Package[apache2],
      notify => Service[apache2];

    "/etc/apache2/mods-enabled/proxy.conf":
      source => 'puppet:///files/etc/apache2/mods-enabled/proxy.conf',
      require => Package[apache2],
      notify => Service[apache2];
  }

  File["/etc/apache2/mods-enabled/proxy.load"] ->
  File["/etc/apache2/mods-enabled/proxy_http.load"] ->
    File["/etc/apache2/mods-enabled/proxy.conf"]
}