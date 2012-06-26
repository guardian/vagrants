class elasticsearch-plugins {

  Exec {
    refreshonly => true,
    subscribe => Package["elasticsearch"]
  }

  exec {
    "install-elasticsearch-plugin-head":
      command => "/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head";
  }

  exec {
    "install-elasticsearch-plugin-paramedic":
      command => "/usr/share/elasticsearch/bin/plugin -install karmi/elasticsearch-paramedic";
  }

  exec {
    "install-elasticsearch-plugin-bigdesk":
      command => "/usr/share/elasticsearch/bin/plugin -install lukas-vlcek/bigdesk";
  }
}