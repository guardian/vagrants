node default {

  File {
    owner => root,
    group => root,
    mode => 644
  }

  file {
    "/etc/hosts":
      source => "puppet:///files/etc/hosts";

    "/etc/elasticsearch/elasticsearch.yml":
      content => template("elasticsearch.yml.erb");
  }

  # The elasticsearch service doesn't listen to reason.
  exec {
    restart-elasticsearch:
      command => "/usr/sbin/service elasticsearch restart",
      refreshonly => true,
      subscribe => File["/etc/elasticsearch/elasticsearch.yml"];
  }

  service {
    elasticsearch: ensure => running;
  }

  File["/etc/elasticsearch/elasticsearch.yml"] ->
    Exec["restart-elasticsearch"] ->
    Service["elasticsearch"]
}