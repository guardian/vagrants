class standard-packages {

  package {
    [
      bash-completion,
      vim,
      curl,
      unzip,
      ntp
    ]: ensure => latest;
  }
}