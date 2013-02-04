# Manage an Apache Pig installation
class hadoop::pig {

  require java

  $url = 'http://mirror.ox.ac.uk/sites/rsync.apache.org/pig/pig-0.9.2'
  $filename = 'pig_0.9.2-1_i386.deb'

  exec {
    'download-pig':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      timeout => 0;
  }

  package {
    'pig':
      ensure   => installed,
      provider => dpkg,
      source   => "/root/${filename}";
  }

  Exec['download-pig'] -> Package['pig']
}