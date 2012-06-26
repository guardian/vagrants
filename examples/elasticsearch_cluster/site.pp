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

  service {
    elasticsearch:
      ensure => running,
      subscribe => File["/etc/elasticsearch/elasticsearch.yml"];
  }
}