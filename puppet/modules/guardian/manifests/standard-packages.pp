class standard-packages {

  package {
    [
      bash-completion,
      vim,
      curl,
      unzip
    ]: ensure => latest;
  }
}