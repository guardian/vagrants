Vagrant Development Boxes
=========================

Vagrant VM boxes for Guardian projects.


Preliminaries: VirtualBox and Vagrant
-------------------------------------
[Vagrant][vagrant] is a tool to "create and configure lightweight, reproducible,
and portable development environments." Vagrant itself is a virtual instance
creation and startup tool on top of Oracle VirtualBox which takes care of the
virtualisation.

Download and install the Open Source Edition of VirtualBox from [virtualbox].

Then download and install Vagrant from [vagrant]. The Linux packages install
the `vagrant` executable at `/opt/vagrant/bin` and you will need to add this to
your path.


`apache2_precise64`
--------------
The basic Ubuntu box with an Apache 2 installation.

    vagrant init nginx_precise64 http://path-to-apache2_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch:

    rake output/apache2_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 80 to the host machine.

    config.vm.forward_port 80, 8000

This forwards port 80 to port 8000 on the host machine to avoid clashes with
existing webservers on the host box.


`nginx_precise64`
--------------
The basic Ubuntu box with an NGINX installation.

    vagrant init nginx_precise64 http://path-to-nginx_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch:

    rake output/nginx_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 80 to the host machine.

    config.vm.forward_port 80, 8000

This forwards port 80 to port 8000 on the host machine to avoid clashes with
existing webservers on the host box.


`elasticsearch_precise64`
---------------------
The basic Ubuntu box with an ElasticSearch installation.

    vagrant init elasticsearch_precise64 http://path-to-elasticsearch_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/elasticsearch_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 9200 for ElasticSearch.

    config.vm.forward_port 9200, 9200

A number of ElasticSearch plugins are included in this box. See:

    http://localhost:9200/_plugin/head/
    http://localhost:9200/_plugin/paramedic/index.html
    http://localhost:9200/_plugin/bigdesk/


`mongodb_precise64`
---------------------
The basic Ubuntu box with a MongoDB installation.

    vagrant init mongodb_precise64 http://path-to-mongodb_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch:

    rake output/mongodb_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward ports 27017 and 28017 to the host
machine for MongoDB.

    config.vm.forward_port 27017, 27017
    config.vm.forward_port 28017, 28017

The MongoDB web interface is available:

    http://localhost:28017


`mysql_precise64`
---------------------
The basic Ubuntu box with a MySQL installation.

    vagrant init mysql_precise64 http://path-to-mysql_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/mysql_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 3306.

    config.vm.forward_port 3306, 3306


`infinidb_precise64`
---------------------
The basic Ubuntu box with an InfiniDB installation.

    vagrant init infinidb_precise64 http://path-to-infinidb_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/infinidb_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 3306.

    config.vm.forward_port 3306, 3306


`neo4j_precise64`
---------------------
The basic Ubuntu box with a Neo4J installation.

    vagrant init neo4j_precise64 http://path-to-neo4j_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/neo4j_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 7474.

    config.vm.forward_port 7474, 7474

The Neo4J interface is available at:

    http://localhost:7474


`postgres_precise64`
---------------------
The basic Ubuntu box with a PostgreSQL installation.

    vagrant init postgres_precise64 http://path-to-postgres_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/postgres_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 5432.

    config.vm.forward_port 5432, 5432


`hadoop_precise64`
---------------------
The basic Ubuntu box with a Hadoop setup. Note that clients must start the
Hadoop services they require. Starting without client services allows this box
to be used in various Hadoop configurations.

    vagrant init hadoop_precise64 http://path-to-hadoop_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/hadoop_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

Clients that use this box should include puppet provisioning like follows to
start services:

    service {
      "hadoop-namenode":
        provider => "init",
        hasstatus => true,
        start => "/etc/init.d/hadoop/namenode start",
        status => "/etc/init.d/hadoop/namenode status",
        stop => "/etc/init.d/hadoop/namenode stop",
        ensure => running;

      "hadoop-secondarynamenode":
        provider => "init",
        hasstatus => true,
        start => "/etc/init.d/hadoop/secondarynamenode start",
        status => "/etc/init.d/hadoop/secondarynamenode status",
        stop => "/etc/init.d/hadoop/secondarynamenode stop",
        ensure => running;

      "hadoop-datanode":
        provider => "init",
        hasstatus => true,
        start => "/etc/init.d/hadoop/datanode start",
        status => "/etc/init.d/hadoop/datanode status",
        stop => "/etc/init.d/hadoop/datanode stop",
        ensure => running;

      "hadoop-jobtracker":
        provider => "init",
        hasstatus => true,
        start => "/etc/init.d/hadoop/jobtracker start",
        status => "/etc/init.d/hadoop/jobtracker status",
        stop => "/etc/init.d/hadoop/jobtracker stop",
        ensure => running;

      "hadoop-tasktracker":
        provider => "init",
        hasstatus => true,
        start => "/etc/init.d/hadoop/tasktracker start",
        status => "/etc/init.d/hadoop/tasktracker status",
        stop => "/etc/init.d/hadoop/tasktracker stop",
        ensure => running;
    }

    Service["hadoop-namenode"] ->
      Service["hadoop-secondarynamenode"] ->
      Service["hadoop-datanode"] ->
      Service["hadoop-jobtracker"] ->
      Service["hadoop-tasktracker"]

The custom service commands are a result of broken init scripts. See the
examples in `examples/hadoop_standalone` and `examples/hadoop_cluster` for more.

`VagrantFiles` using this box can forward ports 50030, 50060, 50070, and
50075 to the host machine for the Hadoop web monitoring interfaces.

    config.vm.forward_port 50030, 50030
    config.vm.forward_port 50060, 50060
    config.vm.forward_port 50070, 50070
    config.vm.forward_port 50075, 50075

The HDFS web interface is available:

    http://localhost:50070/

The Job Tracker web interface is available:

    http://localhost:50030/

The Task Tracker web interface is available:

    http://localhost:50060/

The following is a simple Hadoop execution test:

    $ hadoop fs -put /etc/hadoop input
    $ hadoop jar /usr/share/hadoop/hadoop-examples-*.jar grep input output 'dfs[a-z.]+'
    $ hadoop fs -cat output/*

This VM comes with Apache Pig installed. The following is a simple Pig execution
test:

    $ hadoop fs -put /etc/passwd passwd
    $ pig
    grunt> A = load 'passwd' using PigStorage(':');
    grunt> B = foreach A generate $0 as id;
    grunt> dump B;

This VM also comes with Apache Hive installed. The following is a simple Hive
execution test:

    $ wget 'http://www.grouplens.org/system/files/ml-100k.zip'
    $ unzip ml-100k.zip
    $ hive
    > CREATE TABLE u_data (userid INT, movieid INT, rating INT, unixtime STRING)
      ROW FORMAT DELIMITED
      FIELDS TERMINATED BY '\t'
      STORED AS TEXTFILE;
    > LOAD DATA LOCAL INPATH 'ml-100k/u.data' OVERWRITE INTO TABLE u_data;
    > SELECT COUNT(*) FROM u_data;


`hadoop2_precise64`
---------------------
The basic Ubuntu box with a Hadoop 2 setup.

    vagrant init hadoop2_precise64 http://path-to-hadoop2_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/hadoop2_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box can forward ports 8042, 8088, 8888, 11000, 11001,
19888, 50070 and 50075 to the host machine for the web monitoring interfaces.

    config.vm.forward_port 8042, 8042
    config.vm.forward_port 8088, 8088
    config.vm.forward_port 8888, 8888
    config.vm.forward_port 11000, 11000
    config.vm.forward_port 11001, 11001
    config.vm.forward_port 19888, 19888
    config.vm.forward_port 50070, 50070
    config.vm.forward_port 50075, 50075

The HDFS web interface is available:

    http://localhost:50070/

The following is a simple Hadoop execution test:

    $ hadoop fs -put /etc/hadoop input
    $ hadoop jar /usr/share/hadoop/hadoop-examples-*.jar grep input output 'dfs[a-z.]+'
    $ hadoop fs -cat output/*

This VM comes with Apache Pig installed. The following is a simple Pig execution
test:

    $ hadoop fs -put /etc/passwd passwd
    $ pig
    grunt> A = load 'passwd' using PigStorage(':');
    grunt> B = foreach A generate $0 as id;
    grunt> dump B;

This VM also comes with Apache Hive installed. The following is a simple Hive
execution test:

    $ wget 'http://www.grouplens.org/system/files/ml-100k.zip'
    $ unzip ml-100k.zip
    $ hive
    > CREATE TABLE u_data (userid INT, movieid INT, rating INT, unixtime STRING)
      ROW FORMAT DELIMITED
      FIELDS TERMINATED BY '\t'
      STORED AS TEXTFILE;
    > LOAD DATA LOCAL INPATH 'ml-100k/u.data' OVERWRITE INTO TABLE u_data;
    > SELECT COUNT(*) FROM u_data;


`zookeeper_precise64`
---------------------
The basic Ubuntu box with a Zookeeper installation.

    vagrant init zookeeper_precise64 http://path-to-zookeeper_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/zookeeper_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box can forward port 2181 to potentially acccess the
Zookeeper data from the host machine.

    config.vm.forward_port 2181, 2181

The `ZooInspector` tool can be used from the VMs with X forwarding to inspect
the ZooKeeper configuration. Ensure X forwarding is enabled in the
`Vagrantfile`:

    config.ssh.forward_x11 = true

On the host machine, add an `xhost` for the Vagrant VM:

    xhost +10.0.0.2

Then ssh to the VM and start `zooinspector`:

    vagrant ssh
    > zooinspector


`vowpalwabbit_precise64`
------------------------
The basic Ubuntu box with a Vowpal Wabbit installation.

    vagrant init vowpalwabbit_precise64 http://path-to-vowpalwabbit_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/vowpalwabbit_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.


`sage_precise64`
----------------
The basic Ubuntu box with a Sage Math installation.

    vagrant init sage_precise64 http://path-to-sage_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/sage_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

The Sage notebook web interface:

    http://localhost:8080

Login with user `admin` and password `password`.


`saiku_precise64`
---------------------
The basic Ubuntu box with a Saiku on top of InfiniDB installation.

    vagrant init saiku_precise64 http://path-to-saiku_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake output/saiku_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 3306 and port 8080.

    config.vm.forward_port 3306, 3306
    config.vm.forward_port 8080, 8080


`boxgrinder_precise64`
---------------------
The basic Ubuntu box with a Boxgrinder installation for building VMs.

    vagrant init boxgrinder_precise64 http://path-to-boxgrinder_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake ouput/boxgrinder_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

The Apt cache web interface:

    http://localhost:9999/acng-report.html

The following is a simple Boxgrinder execution test:

    $ export BOXGRINDER_DEBUG_VMBUILDER=1
    $ boxgrinder-build --debug -l boxgrinder-ubuntu-plugin precise.appl

Where the `precise.appl` file consists of:

    name: precise
    summary: Sample Ubuntu appliance
    os:
      name: ubuntu
      version: precise
    hardware:
      partitions:
        "/":
          size: 1
    packages:
      includes:
        - git
        - puppet
        - ntp
        - openjdk-6-jdk


`dev_precise64`
---------------------
The basic Ubuntu box with a support tools for developing vagrants.

    vagrant init dev_precise64 http://path-to-dev_precise64.box
    vagrant up

And ssh onto it:

    vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    rake ouput/dev_precise64.box


Examples
--------
Example multi-VM stacks are included under `examples`. At present, these
include some standalone single VM:

* `elasticsearch_standalone`: A standalone ElasticSearch instance.
* `mongodb_standalone`: A standalone MongoDB instance.
* `mysql_standalone`: A standalone MySQL instance.
* `infinidb_standalone`: A standalone InfiniDB instance.
* `neo4j_standalone`: A standalone Neo4J instance.
* `postgres_standalone`: A standalone PostgreSQL instance.
* `hadoop_standalone`: A standalone Hadoop instance demonstrating how to start
  the Hadoop services.
* `hadoop2_standalone`: A standalone Hadoop 2 instance.
* `zookeeper_standalone`: A standalone Zookeeper instance.
* `sage_standalone`: A standalone Sage instance.
* `vowpalwabbit_standalone`: A standalone Vowpal Wabbit instance.
* `saiku_standalone`: A standalone Saiku instance.
* `boxgrinder_standalone`: A standalone Boxgrinder instance.

Some example webserver configurations:

* `apache2_play_standalone`: A standalone Apache 2 instance demonstrating a
   proxy configuration suitable for a Play application server on the same box.
* `nginx_play_standalone`: A standalone NGINX instance demonstrating a proxy
   configuration suitable for a Play application server on the same box.

Some example stacks:

* `elasticsearch_stack`: An application server with a separate ElasticSearch
  backend VM.
* `mongodb_stack`: An application server with a separate MongoDB backend VM.
* `neo4j_stack`: An application server with a separate Neo4J backend VM.

And some more complicated clusers:

* `elasticsearch_cluster`: A three node cluster of ElasticSearch VMs.
* `mongodb_cluster`: A three node replica set cluster of MongoDB VMs.
* `hadoop_cluster`: A three node cluster of Hadoop VMs.
* `zookeeper_cluster`: A three node cluster of Zookeeper VMs.


Vagrant Commmands
-----------------
* `vagrant suspend`: Disable the virtual instance. The allocated disc space for
  the instance is retained but the instance will not be available. The running
  state at suspend time is saved for resumption.
* `vagrant resume`: Wake up a previously suspended virtual instance.
* `vagrant halt`: Turn off the virtual instance. Calling `vagrant up` after this
  is the equivalent of a reboot.
* `vagrant up --no-provision`: Bring up the virtual instance without doing the
  provisioning step. Useful if the provisioning step is destructive.
* `vagrant destroy`: Hose your virtual instance, reclaiming the allocated disc
  space.
* `vagrant provision`: Rerun puppet or chef provisioning on the virtual
  instance.


Vagrant SSH X Forwarding
------------------------
X applications on VMs can be displayed on the host machine by specifying a
Vagrant SSH connection with X11 forwarding in the `Vagrantfile`:

    config.ssh.forward_x11 = true

On the host machine, add an `xhost` for the Vagrant VM:

    xhost +10.0.0.2

Then X applications started from the VM should display on the host machine.



Vagrant Troubleshooting
-----------------------

To see more verbose output on any vagrant command, add a VAGRANT_LOG environment
variable setting, e.g.:

    VAGRANT_LOG=INFO vagrant up

Further help troubleshooting can be obtained by editing your `Vagrantfile` and
enabling the `config.vm.boot_mode = :gui` setting. This will pop up a VirtualBox
GUI window on boot.

There have been some issues getting 64bit instances to start. The error is
apparent in GUI boot:

    VT-x/AMD-V hardware acceleration has been enabled, but is not
    operational. Your 64-bit guest will fail to detect a 64-bit CPU and
    will not be able to boot.

Some BIOS setting changes can help. The changes are described at
`http://dba-star.blogspot.com/2011/11/how-to-enable-vtx-and-vtd-on-hp-compaq.html`
but briefly:

1. Restart your developer box.
2. Press F10 for BIOS settings at the boot splash.
3. Edit Security -> System Security (I wasn't expecting it here either!)
4. Enable VT-x and VT-d settings.
5. Save and exit.

[vagrant]: http://vagrantup.com
[virtualbox-download]: https://www.virtualbox.org/wiki/Linux_Downloads
