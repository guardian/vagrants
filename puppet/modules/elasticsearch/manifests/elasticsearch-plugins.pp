class elasticsearch-plugins {

  exec {
    "install-elasticsearch-plugin-head":
      command => "/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head",
      refreshonly => true,
      subscribe => Package["elasticsearch"];
  }

  exec {
    "install-elasticsearch-plugin-paramedic":
      command => "/usr/share/elasticsearch/bin/plugin -install karmi/elasticsearch-paramedic",
      refreshonly => true,
      subscribe => Package["elasticsearch"];
  }

  exec {
    "install-elasticsearch-plugin-bigdesk":
      command => "/usr/share/elasticsearch/bin/plugin -install lukas-vlcek/bigdesk",
      refreshonly => true,
      subscribe => Package["elasticsearch"];
  }

}