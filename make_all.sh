#!/bin/bash

BOXES="base_lucid64  play_lucid64  play_extras_lucid64  base_precise64  play_extras_precise64  play_precise64"
VAGRANT=/opt/vagrant/bin/vagrant

for BOX in ${BOXES}
do
  echo "Building box: ${BOX}"
  pushd ${BOX} > /dev/null

  rm -f ${BOX}.box .vagrant
  ${VAGRANT} up && ${VAGRANT} package --output ${BOX}.box

  if [ $? != 0 ]
  then
    echo "Error in box creation. Exiting."
    exit 1
  fi

  popd > /dev/null
done

for BOX in ${BOXES}
do
  echo "Uploading box: ${BOX}"
  pushd ${BOX} > /dev/null

  scp ${BOX}.box root@devscreen:/var/www/html/vagrants

  popd > /dev/null
done