Vagrant::Config.run do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # config.vm.boot_mode = :gui
  config.ssh.forward_x11 = true

  config.vm.provision :puppet,
    :options => ["--debug", "--modulepath=/vagrant/modules"] do |puppet|
    puppet.manifests_path = "."
    puppet.manifest_file = "site.pp"
  end


  ##############################################################################
  # Web Servers
  ##############################################################################

  config.vm.define :apache2_precise64 do |apache2|
    apache2.vm.host_name = "apache2"
    apache2.vm.customize [ "modifyvm", :id, "--name", "apache2_precise64" ]
    apache2.vm.forward_port 80, 8000
  end

  config.vm.define :nginx_precise64 do |nginx|
    nginx.vm.host_name = "nginx"
    nginx.vm.customize [ "modifyvm", :id, "--name", "nginx_precise64" ]
    nginx.vm.forward_port 80, 8000
  end


  ##############################################################################
  # Databases
  ##############################################################################

  config.vm.define :elasticsearch_precise64 do |elasticsearch|
    elasticsearch.vm.host_name = "elasticsearch"
    elasticsearch.vm.customize [ "modifyvm", :id, "--name", "elasticsearch_precise64" ]
    elasticsearch.vm.forward_port 9200, 9200
  end

  config.vm.define :mongodb_precise64 do |mongodb|
    mongodb.vm.host_name = "mongodb"
    mongodb.vm.customize [ "modifyvm", :id, "--name", "mongodb_precise64" ]
    mongodb.vm.forward_port 27017, 27017
    mongodb.vm.forward_port 28017, 28017
  end

  config.vm.define :mysql_precise64 do |mysql|
    mysql.vm.host_name = "mysql"
    mysql.vm.customize [ "modifyvm", :id, "--name", "mysql_precise64" ]
    mysql.vm.forward_port 3306, 3306
  end

  config.vm.define :neo4j_precise64 do |neo4j|
    neo4j.vm.host_name = "neo4j"
    neo4j.vm.customize [ "modifyvm", :id, "--name", "neo4j_precise64" ]
    neo4j.vm.forward_port 7474, 7474
  end

  config.vm.define :postgres_precise64 do |postgres|
    postgres.vm.host_name = "postgres"
    postgres.vm.customize [ "modifyvm", :id, "--name", "postgres_precise64" ]
    postgres.vm.forward_port 5432, 5432
  end


  ##############################################################################
  # MapReduce
  ##############################################################################

  config.vm.define :hadoop_precise64 do |hadoop|
    hadoop.vm.host_name = "hadoop"
    hadoop.vm.customize [ "modifyvm", :id, "--name", "hadoop_precise64" ]
    hadoop.vm.forward_port 50030, 50030
    hadoop.vm.forward_port 50060, 50060
    hadoop.vm.forward_port 50070, 50070
    hadoop.vm.forward_port 50075, 50075
  end 
  
  config.vm.define :hadoop2_precise64 do |hadoop2|
    hadoop2.vm.host_name = "hadoop2"
    hadoop2.vm.customize [ "modifyvm", :id, "--name", "hadoop2_precise64" ]
    hadoop2.vm.forward_port 8042, 8042
    hadoop2.vm.forward_port 8088, 8088
    hadoop2.vm.forward_port 8888, 8888
    hadoop2.vm.forward_port 11000, 11000
    hadoop2.vm.forward_port 11001, 11001
    hadoop2.vm.forward_port 19888, 19888
    hadoop2.vm.forward_port 50070, 50070
    hadoop2.vm.forward_port 50075, 50075
  end  

  config.vm.define :zookeeper_precise64 do |zookeeper|
    zookeeper.vm.host_name = "zookeeper"
    zookeeper.vm.customize [ "modifyvm", :id, "--name", "zookeeper_precise64" ]
    zookeeper.vm.forward_port 2181, 2181
  end


  ##############################################################################
  # Data Analysis
  ##############################################################################

  config.vm.define :sage_precise64 do |sage|
    sage.vm.host_name = "sage"
    sage.vm.customize [ "modifyvm", :id, "--name", "sage_precise64" ]
    sage.vm.forward_port 8080, 8080
  end

  config.vm.define :vowpalwabbit_precise64 do |vowpalwabbit|
    vowpalwabbit.vm.host_name = "vowpalwabbit"
    vowpalwabbit.vm.customize [ "modifyvm", :id, "--name", "vowpalwabbit_precise64" ]
  end


  ##############################################################################
  # Development support
  ##############################################################################

  config.vm.define :boxgrinder_precise64 do |boxgrinder|
    boxgrinder.vm.host_name = "boxgrinder"
    boxgrinder.vm.customize [ "modifyvm", :id, "--name", "boxgrinder_precise64" ]
  end

  config.vm.define :dev_precise64 do |dev|
    dev.vm.host_name = "dev"
    dev.vm.customize [ "modifyvm", :id, "--name", "dev_precise64" ]
  end
end
