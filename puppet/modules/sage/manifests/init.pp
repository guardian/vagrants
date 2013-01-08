class sage {

  file {
    '/etc/init.d/sage':
      source => 'puppet:///modules/sage/etc/init.d/sage',
      owner  => root,
      group  => root,
      mode   => '0744';

    '/etc/init/sage.conf':
      source => 'puppet:///modules/sage/etc/init/sage.conf',
      owner  => root,
      group  => root,
      mode   => '0644';

    '/root/sage.setup':
      source => 'puppet:///modules/sage/root/sage.setup',
      owner  => root,
      group  => root,
      mode   => '0744';
  }

  package {
    [
      'build-essential',
      'libcairo2-dev',
      'libfontconfig1',
      'texlive',
      'dvipng',
      'imagemagick',
      'expect'
    ]: ensure => latest;
  }

  $url = 'http://www.mirrorservice.org/sites/www.sagemath.org/linux/64bit'
  $filename = 'sage-5.5-linux-64bit-ubuntu_12.04.1_lts-x86_64-Linux.tar.lzma'
  $filename_extracted = 'sage-5.5-linux-64bit-ubuntu_12.04.1_lts-x86_64-Linux'

  exec {
    'download-sage':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      timeout => 0;

    'extract-sage':
      cwd     => '/opt',
      command => "/bin/tar --lzma -xvf /root/${filename} && mv ${filename_extracted} sage",
      creates => '/opt/sage';

    'setup-sage':
      cwd     => '/root',
      command => "/root/sage.setup";
  }

  service {
    'sage':
      ensure   => running,
      enable   => true,
      provider => 'upstart';
  }

  File['/root/sage.setup'] -> Exec['setup-sage']
  Package['build-essential'] -> Exec['setup-sage']

  Package['libfontconfig1'] -> Service[sage]
  Package['texlive'] -> Service[sage]
  Package['dvipng'] -> Service[sage]
  Package['imagemagick'] -> Service[sage]
  Package['expect'] -> Service[sage]

  File['/etc/init.d/sage'] -> Service[sage]
  File['/etc/init/sage.conf'] -> Service[sage]

  Exec['download-sage'] ->
    Exec['extract-sage'] ->
    Exec['setup-sage'] ->
    Service[sage]
}