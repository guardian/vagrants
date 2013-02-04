# Manage an ElasticSearch installation
class elasticsearch {

  require java

  $url = 'http://download.elasticsearch.org/elasticsearch/elasticsearch'
  $filename = 'elasticsearch-0.20.4.deb'

  exec {
    'download-elasticsearch':
      command => "/usr/bin/wget ${url}/${filename}",
      cwd     => '/root',
      creates => "/root/${filename}",
      timeout => 0;
  }

  package {
    'elasticsearch':
      ensure   => installed,
      provider => dpkg,
      source   => "/root/${filename}";
  }

  $head = 'mobz/elasticsearch-head'
  $paramedic = 'karmi/elasticsearch-paramedic'
  $bigdesk = 'lukas-vlcek/bigdesk'

  exec {
    'install-elasticsearch-head':
      command => "/usr/share/elasticsearch/bin/plugin -install ${head}",
      creates => '/usr/share/elasticsearch/plugins/head';

    'install-elasticsearch-paramedic':
      command => "/usr/share/elasticsearch/bin/plugin -install ${paramedic}",
      creates => '/usr/share/elasticsearch/plugins/paramedic';

    'install-elasticsearch-bigdesk':
      command => "/usr/share/elasticsearch/bin/plugin -install ${bigdesk}",
      creates => '/usr/share/elasticsearch/plugins/bigdesk';
  }

  file {
    # Fixup for Elasticsearch JVM search
    '/usr/lib/jvm/java-6-openjdk':
      ensure => 'link',
      target => '/usr/lib/jvm/java-6-openjdk-amd64';
  }

  service {
    'elasticsearch':
      ensure => running,
      enable => true;
  }

  Exec[download-elasticsearch] ->
    Package[elasticsearch] ->
    Exec[install-elasticsearch-head] ->
    Exec[install-elasticsearch-paramedic] ->
    Exec[install-elasticsearch-bigdesk] ->
    File['/usr/lib/jvm/java-6-openjdk'] ->
    Service[elasticsearch]
}