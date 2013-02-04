# Manage a Vagrants development installation
class dev {

  require ruby

  package {
    'git': ensure => latest;
  }

  package {
    [
      'puppet-lint',
      'librarian-puppet'
    ]:
      ensure   => latest,
      provider => 'gem';
  }
}