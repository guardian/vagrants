# Manage a Saiku installation with InfiniDB
class saiku {

  require tomcat7
  require infinidb

  $url = 'http://analytical-labs.com/downloads'
  $filename = 'saiku-webapp-foodmart-2.4.war'
  $ui_filename = 'saiku-ui-2.4.war'

  exec {
    'download-saiku':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      timeout => 0;

    'install-saiku':
      command => "/bin/cp ${filename} /var/lib/tomcat7/webapps/saiku.war",
      cwd     => '/root',
      creates => '/var/lib/tomcat7/webapps/saiku.war',
      timeout => 0;

    'download-saiku-ui':
      command => "/usr/bin/wget ${url}/${ui_filename}",
      cwd     => '/root',
      creates => "/root/${ui_filename}",
      timeout => 0;

    'install-saiku-ui':
      command => "/bin/cp ${ui_filename} /var/lib/tomcat7/webapps/ROOT.war",
      cwd     => '/root',
      creates => '/var/lib/tomcat7/webapps/ROOT.war',
      timeout => 0;
  }

  file {
    '/var/lib/tomcat7/webapps':
      ensure => directory,
      recurse => true,
      purge => true,
      force => true,
      owner => 'root',
      group => 'root',
      mode => 0666
  }

  Exec[download-saiku] ->
    Exec[download-saiku-ui] ->
    File['/var/lib/tomcat7/webapps'] ->
    Exec[install-saiku] ->
    Exec[install-saiku-ui]
}