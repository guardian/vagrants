# Standard installation for Guardian boxes.
class guardian {

  require guardian::apt

  file {
    '/etc/gu':
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755';

    '/etc/gu/install_vars':
      source => 'puppet:///modules/guardian/etc/gu/install_vars',
      owner  => root,
      group  => root,
      mode   => '0644';
  }

  package {
    [
      'bash-completion',
      'vim',
      'curl',
      'unzip'
    ]: ensure => latest;
  }

  include ntp
}
