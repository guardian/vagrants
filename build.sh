#!/bin/bash

BOXES="base_precise64"
BOXES="$BOXES nginx_precise64 apache2_precise64"
BOXES="$BOXES mongodb_precise64 elasticsearch_precise64 neo4j_precise64 mysql_precise64"
BOXES="$BOXES nginx_extras_precise64"
BOXES="$BOXES zookeeper_precise64 hadoop_precise64"
BOXES="$BOXES boxgrinder_precise64"

VAGRANT=/opt/vagrant/bin/vagrant

for BOX in ${BOXES}
do
  echo "Building box: ${BOX}"
  pushd ${BOX} > /dev/null

  rm -fr ../output/${BOX}.box .vagrant
  ${VAGRANT} up && ${VAGRANT} package --output ../output/${BOX}.box

  if [ $? != 0 ]
  then
    echo "Error in box creation. Exiting."
    exit 1
  fi

  popd > /dev/null
done
