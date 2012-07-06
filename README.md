Vagrant Development Boxes
=========================

Preliminaries: Install Vagrant(Ubuntu)
--------------------------------------
[Vagrant][vagrant] is a tool to "create and configure lightweight, reproducible,
and portable development environments." Vagrant itself is a virtual instance
creation and startup tool on top of Oracle VirtualBox which takes care of the
virtualisation.

Install the Open Source Edition of VirtualBox:

    wget http://download.virtualbox.org/virtualbox/4.1.18/virtualbox-4.1_4.1.18-78361~Ubuntu~natty_amd64.deb
    sudo dpkg -i virtualbox-4.1_4.1.18-78361~Ubuntu~natty_amd64.deb

If you are using a different version of Ubuntu, substitute the appropriate deb
from the [VirtualBox download page][virtualbox-download].

Then install Vagrant itself:

    wget http://files.vagrantup.com/packages/eb590aa3d936ac71cbf9c64cf207f148ddfc000a/vagrant_1.0.3_x86_64.deb
    sudo dpkg -i vagrant_1.0.3_x86_64.deb


Preliminaries: IntelliJ Project Files
-------------------------------------
Because this is not a builded project, there is no support for automatically
creating IntelliJ project definitions. If you want to use the IntelliJ editors
you will need to create a new project in IntelliJ. Use the Create project from
existing sources, unmark the source files that IntelliJ finds and confirm
project creation.

In the new project, go to Project Structure and create a new module from scratch
specifying the project base directory as the content root. Do not create a
source directory and finish. In the newly constructed module, add the project
base directory as a sources directory.

Your project should now be setup for editing.


`base_precise64`
--------------
Basic Ubuntu 12.04 box with `/etc/gu`, apt configuration and Java.

    /opt/vagrant/bin/vagrant init base_precise64 http://path-to-base_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch:

    cd base_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output ../output/base_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.


`nginx_precise64`
--------------
The basic Ubuntu box with an NGINX installation.

    /opt/vagrant/bin/vagrant init nginx_precise64 http://path-to-nginx_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch:

    cd nginx_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output ../output/nginx_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 80 to the host machine.

    config.vm.forward_port 80, 8000

This forwards port 80 to port 8000 on the host machine to avoid clashes with
existing webservers on the host box.


`apache2_precise64`
--------------
The basic Ubuntu box with an Apache 2 installation.

    /opt/vagrant/bin/vagrant init nginx_precise64 http://path-to-apache2_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch:

    cd nginx_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output ../output/nginx_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 80 to the host machine.

    config.vm.forward_port 80, 8000

This forwards port 80 to port 8000 on the host machine to avoid clashes with
existing webservers on the host box.


`mongodb_precise64`
---------------------
The basic Ubuntu box with a MongoDB installation.

    /opt/vagrant/bin/vagrant init mongodb_precise64 http://path-to-mongodb_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    cd mongodb_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output ../output/mongodb_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward ports 27017 and 28017 to the host
machine for MongoDB.

    config.vm.forward_port 27017, 27017
    config.vm.forward_port 28017, 28017

The MongoDB web interface is available:

    http://localhost:28017


`elasticsearch_precise64`
---------------------
The basic Ubuntu box with an ElasticSearch installation.

    /opt/vagrant/bin/vagrant init elasticsearch_precise64 http://path-to-elasticsearch_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    cd elasticsearch_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output ../output/elasticsearch_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 9200 for ElasticSearch.

    config.vm.forward_port 9200, 9200

A number of ElasticSearch plugins are included in this box. See:

    http://localhost:9200/_plugin/head/
    http://localhost:9200/_plugin/paramedic/index.html
    http://localhost:9200/_plugin/bigdesk/


`neo4j_precise64`
---------------------
The basic Ubuntu box with a Neo4J installation.

    /opt/vagrant/bin/vagrant init neo4j_precise64 http://path-to-neo4j_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    cd neo4j_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output ../output/neo4j_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 7474.

    config.vm.forward_port 7474, 7474

The Neo4J interface is available at:

    http://localhost:7474


`hadoop_precise64`
---------------------
The basic Ubuntu box with a Hadoop setup. Note that clients must start the
Hadoop services they require. Starting without client services allows this box
to be used in various Hadoop configurations.

    /opt/vagrant/bin/vagrant init hadoop_precise64 http://path-to-hadoop_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch, first build `base_precise64`, then:

    cd hadoop_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output ../output/hadoop_precise64.box

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

See the example in `examples/hadoop_pig_standalone` for a Vagrant configuration
that includes restarting the Hadoop services.


`aws_elastic_mapreduce_hadoop_precise64`
----------------------------------------
The `hadoop_precise64` box but with the same version of Hadoop used in Amazon
Web Services Elastic MapReduce. Note the Amazon distribution has some minor
variations. Use is as per `hadoop_precise64`.


`nginx_extras_precise64`
---------------------
A version of `nginx_precise64` with ElasticSearch, Mongodb, Neo4J and Hadoop.

    /opt/vagrant/bin/vagrant init play_extras_precise64 http://path-to-nginx_extras_precise64.box
    /opt/vagrant/bin/vagrant up

And ssh onto it:

    /opt/vagrant/bin/vagrant ssh

To build the package from scratch, first build `nginx_precise64`, then:

    cd nginx_extras_precise64
    /opt/vagrant/bin/vagrant up
    /opt/vagrant/bin/vagrant package --output ../output/nginx_extras_precise64.box

The puppet provisioning during the `vagrant up` step may take some time.

`VagrantFiles` using this box should forward port 80 to the host machine.

    config.vm.forward_port 80, 8000

This forwards port 80 to port 8000 on the host machine to avoid clashes with
existing webservers on the host box.

In addition, forward port 9200 for ElasticSearch.

    config.vm.forward_port 9200, 9200

A number of ElasticSearch plugins are included in this box. See:

    http://localhost:9200/_plugin/head/
    http://localhost:9200/_plugin/paramedic/index.html
    http://localhost:9200/_plugin/bigdesk/

Forward ports 27017 and 28017 to the host machine for MongoDB.

    config.vm.forward_port 27017, 27017
    config.vm.forward_port 28017, 28017

The MongoDB web interface is available:

    http://localhost:28017

Forward port 7474 for Neo4J.

    config.vm.forward_port 7474, 7474

The Neo4J interface is available at:

    http://localhost:7474

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


Examples
--------
Example multi-VM stacks are included under `examples`. At present, these
include some standalone single VM:

* `elasticsearch_standalone`: A standalone ElasticSearch instance.
* `monogodb_standalone`: A standalone MongoDB instance.
* `neo4j_standalone`: A standalone Neo4J instance.
* `hadoop_standalone`: A standalone Hadoop instance demonstrating how to start
  the Hadoop services.
* `aws_elastic_mapreduce_standalone`: A standalone AWS Elastic MapReduce
  example.
* `nginx_extras_standalone`: A standalone instance of the
  `nginx_extras_precise64` VM with ElasticSearch, MongoDB, Neo4J and Hadoop.
  Basically, all the toys.

Some example webserver configurations:

* `nginx_play_standalone`: A standalone NGINX instance demonstrating a proxy
   configuration suitable for a Play application server on the same box.
* `apache2_play_standalone`: A standalone Apache 2 instance demonstrating a
   proxy configuration suitable for a Play application server on the same box.

Some example stacks:

* `elasticsearch_stack`: An application server with a separate ElasticSearch
  backend VM.
* `mongodb_stack`: An application server with a separate MongoDB backend VM.
* `neo4j_stack`: An application server with a separate Neo4J backend VM.

And some more complicated clusers:

* `elasticsearch_cluster`: A three node cluster of ElasticSearch VMs.
* `mongodb_cluster`: A three node replica set cluster of MongoDB VMs.
* `hadoop_cluster`: A three node cluster of Hadoop VMs.


Vagrant Commmands
-----------------

* `/opt/vagrant/bin/vagrant suspend`: Disable the virtual instance. The
  allocated disc space for the instance is retained but the instance will not be
  available. The running state at suspend time is saved for resumption.
* `/opt/vagrant/bin/vagrant resume`: Wake up a previously suspended virtual
  instance.
* `/opt/vagrant/bin/vagrant halt`: Turn off the virtual instance. Calling
  `vagrant up` after this is the equivalent of a reboot.
* `/opt/vagrant/bin/vagrant up --no-provision`: Bring up the virtual instance
  without doing the provisioning step. Useful if the provisioning step is
  destructive.
* `/opt/vagrant/bin/vagrant destroy`: Hose your virtual instance, reclaiming the
  allocated disc space.
* `/opt/vagrant/bin/vagrant provision`: Rerun puppet or chef provisioning on the
  virtual instance.


Vagrant Troubleshooting
-----------------------

To see more verbose output on any vagrant command, add a VAGRANT_LOG environment
variable setting, e.g.:

    VAGRANT_LOG=INFO /opt/vagrant/bin/vagrant up

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