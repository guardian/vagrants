# Manage a Hive installation
class hadoop::hive {

  require java

  file {
    '/etc/profile.d/hive.sh':
      source => 'puppet:///modules/hadoop/etc/profile.d/hive.sh';
  }

  $url = 'http://mirror.ox.ac.uk/sites/rsync.apache.org/hive/hive-0.8.1'
  $filename = 'hive-0.8.1.tar.gz'
  $extracted = 'hive-0.8.1'

  exec {
    'download-hive':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      timeout => 0;

    'extract-hive':
      cwd     => '/usr/share',
      command => "/bin/tar xzf /root/${filename} && mv ${extracted} hive",
      creates => '/usr/share/hive';
  }

  Exec['download-hive'] -> Exec['extract-hive']
}