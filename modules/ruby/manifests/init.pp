# Manage a Ruby installation
class ruby {

  package {
    [
      'ruby',
      'rake',
      'irb',
      'rubygems'
    ]: ensure => latest;
  }
}