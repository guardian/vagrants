node default {

  #############################################################################
  # Following instructions from:
  #    http://www.davidghedini.com/pg/entry/install_oracle_11g_xe_on
  #############################################################################

  #############################################################################
  # Puppet complains about no puppet group at end of run
  #############################################################################

  group {
    'puppet': ensure => present;
  }

  #############################################################################
  # Add another gig of swap to make the 2Gb needed by Oracle XE.
  #############################################################################

  exec {
    'add-additional-swap':
      command => '/vagrant/addAdditionalSwap',
      creates => '/swap',
      timeout => 0;
  }

  Exec['add-additional-swap'] -> Package['oracle-xe-11.2.0-1.0.x86_64']

  #############################################################################
  # Install Oracle XE package
  #
  # Oracle XE is not redistributable so you will need to download `oracle-xe-11.2.0-1.0.x86_64.rpm.zip` from:
  #    http://www.oracle.com/technetwork/database/express-edition/downloads/index.html
  #
  # Unzip this and copy the rpm from `/Disk1` up to the current directory.
  #############################################################################

  package {
    # 'java-1.6.0-openjdk': ensure => installed;

    ['libaio', 'bc', 'flex']: ensure => installed;

    'oracle-xe-11.2.0-1.0.x86_64':
      provider => 'rpm',
      ensure => installed,
      source => '/vagrant/oracle-xe-11.2.0-1.0.x86_64.rpm';
  }

  Package['libaio'] -> Package['oracle-xe-11.2.0-1.0.x86_64']
  Package['bc'] -> Package['oracle-xe-11.2.0-1.0.x86_64']
  Package['flex'] -> Package['oracle-xe-11.2.0-1.0.x86_64']
  Package['java-1.6.0-openjdk'] -> Package['oracle-xe-11.2.0-1.0.x86_64']

  # START: Circumvent ScanSafe with previously downloaded java-1.6.0-openjdk-1.6.0.0-1.30.1.11.5.el5.x86_64.rpm
  # Acquire a java-1.6.0-openjdk-1.6.0.0-1.30.1.11.5.el5.x86_64.rpm by black
  # magic and put it in this directory
  package {
    'java-1.6.0-openjdk':
      provider => 'rpm',
      ensure => installed,
      source => '/vagrant/java-1.6.0-openjdk-1.6.0.0-1.30.1.11.5.el5.x86_64.rpm';

    [
      'jpackage-utils',
      'libXtst',
      'alsa-lib',
      'tzdata-java',
      'giflib',
      'perl'
    ]: ensure => installed;
  }

  Package['jpackage-utils'] -> Package['java-1.6.0-openjdk']
  Package['libXtst'] -> Package['java-1.6.0-openjdk']
  Package['alsa-lib'] -> Package['java-1.6.0-openjdk']
  Package['tzdata-java'] -> Package['java-1.6.0-openjdk']
  Package['giflib'] -> Package['java-1.6.0-openjdk']
  Package['perl'] -> Package['java-1.6.0-openjdk']
  # END: Circumvent ScanSafe


  #############################################################################
  # Configure the Oracle XE installation.
  #############################################################################

  package {
    'expect': ensure => latest;
  }

  exec {
    'configure-oracle-xe':
      command => '/vagrant/configureOracleXE',
      creates => '/root/configuredOracleXE',
      timeout => 0;
  }

  Package['oracle-xe-11.2.0-1.0.x86_64'] -> Exec['configure-oracle-xe']
  Package['expect'] -> Exec['configure-oracle-xe']
}
