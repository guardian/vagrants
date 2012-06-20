node default {

  include guardian
  include nginx
  include java

  file {
    "/etc/nginx/sites-enabled/frontend-server":
      source => 'puppet:///files/etc/nginx/sites-enabled/frontend-server',
      notify => Service[nginx];
  }
}