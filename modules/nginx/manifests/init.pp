# Manage an NGINX installation
class nginx {

  apt::source {
    'nginx':
      location    => 'http://nginx.org/packages/ubuntu/',
      release     => 'precise',
      repos       => 'nginx',
      key         => '7BD9BF62',
      key_server  => 'keyserver.ubuntu.com',
      include_src => false;
  }

  package {
    'nginx': ensure => latest;
  }

  service {
    'nginx':
      ensure => running,
      enable => true;
  }

  Apt::Source['nginx'] -> Package['nginx'] -> Service['nginx']
}