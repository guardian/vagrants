class hive($hive_version = '0.9.0') {

  $hive_distributions = {
    '0.9.0' => {
      'url' => 'http://mirror.ox.ac.uk/sites/rsync.apache.org/hive/hive-0.9.0/hive-0.9.0.tar.gz',
      'filename' => 'hive-0.9.0.tar.gz',
      'extracted' => 'hive-0.9.0'
    },
    '0.8.1' => {
      'url' => 'http://mirror.ox.ac.uk/sites/rsync.apache.org/hive/hive-0.8.1/hive-0.8.1.tar.gz',
      'filename' => 'hive-0.8.1.tar.gz',
      'extracted' => 'hive-0.8.1'
    }
  }

  $download_url = $hive_distributions[$hive_version]['url']
  $download_filename = $hive_distributions[$hive_version]['filename']
  $download_extracted = $hive_distributions[$hive_version]['extracted']

  if (!$download_url) {
    fail("Unsupported Pig distribution: ${hive_version}")
  }

  include guardian
  include java
  include hive-configuration

  file {
    "/etc/profile.d/hive.sh":
      source => "puppet:///modules/hive/etc/profile.d/hive.sh";
  }

  exec {
    "hive-download":
      command => "/usr/bin/wget $download_url",
      cwd => "/var/cache/downloads",
      creates => "/var/cache/downloads/$download_filename",
      timeout => 0;
  }

  exec {
    hive-extract:
      cwd => "/usr/share",
      command => "/bin/tar xzf /var/cache/downloads/$download_filename && mv $download_extracted hive",
      creates => "/usr/share/hive";
  }

  Class["guardian"] ->
    Class["java"] ->
    Exec["hive-download"] ->
    Exec["hive-extract"] ->
    Class["hive-configuration"]

}