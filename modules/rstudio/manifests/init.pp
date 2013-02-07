# Manage an R and RStudio installation
class rstudio {

  require bugs

  apt::source {
    'cran':
      location    => 'http://cran.ma.imperial.ac.uk/bin/linux/ubuntu',
      release     => 'precise/',
      repos       => '',
      key         => 'E084DAB9',
      key_server  => 'keyserver.ubuntu.com',
      include_src => false;
  }

  package {
    [
      'gnuplot',
      'r-base',
      'libjpeg62',
      'texlive',
      'pandoc',
      'libcairo2-dev',
      'build-essential'
    ]: ensure => latest;
  }

  file {
    '/root/R.setup':
      source => 'puppet:///modules/rstudio/root/R.setup',
      owner  => root,
      group  => root,
      mode   => '0744';

    # Fixup for JAGS library path
    '/usr/lib64':
      ensure => 'link',
      target => '/usr/lib';
  }

  $url = 'http://download1.rstudio.org'
  $filename = 'rstudio-0.97.314-amd64.deb'

  exec {
    'download-rstudio':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      timeout => 0;

    'setup-R':
      cwd     => '/root',
      command => '/root/R.setup',
      creates => '/root/R.done',
      timeout => 0;
  }

  package {
    'rstudio':
      ensure   => installed,
      provider => dpkg,
      source   => "/root/${filename}";
  }

  Apt::Source['cran'] -> Package['r-base'] -> Exec['setup-R']

  Package['libjpeg62'] -> Package['rstudio']
  Exec[download-rstudio] -> Package['rstudio']

  File['/root/R.setup'] -> Exec['setup-R']
  File['/usr/lib64'] -> Exec['setup-R']
  Package['libcairo2-dev'] -> Exec['setup-R']
  Package['build-essential'] -> Exec['setup-R']
}