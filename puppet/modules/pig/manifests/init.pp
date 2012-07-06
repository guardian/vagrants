class pig($pig_version = '0.10.0') {

  $pig_distributions = {
    '0.10.0' => {
      'url' => 'http://mirror.ox.ac.uk/sites/rsync.apache.org/pig/pig-0.10.0/pig_0.10.0-1_i386.deb',
      'filename' => 'pig_0.10.0-1_i386.deb'
    },
    '0.9.2' => {
      'url' => 'http://mirror.ox.ac.uk/sites/rsync.apache.org/pig/pig-0.9.2/pig_0.9.2-1_i386.deb',
      'filename' => 'pig_0.9.2-1_i386.deb'
    }
  }

  $download_url = $pig_distributions[$pig_version]['url']
  $download_filename = $pig_distributions[$pig_version]['filename']

  if (!$download_url) {
    fail("Unsupported Pig distribution: ${pig_version}")
  }

  include guardian
  include java

  exec {
    "download-pig-deb":
      command => "/usr/bin/wget ${download_url}",
      cwd => "/var/cache/apt/archives",
      creates => "/var/cache/apt/archives/${download_filename}",
      timeout => 0;
  }

  package {
    pig:
      provider => dpkg,
      ensure => installed,
      source => "/var/cache/apt/archives/${download_filename}";
  }

  Class["guardian"] ->
    Class["java"] ->
    Exec["download-pig-deb"] ->
    Package["pig"]
}