#!/bin/bash -e

BOX=devschema_xe_centos5
VAGRANT=/opt/vagrant/bin/vagrant


echo "Removing previous builds: ${BOX}"
${VAGRANT} destroy -f
${VAGRANT} box remove ${BOX} || true
rm -fr ../output/${BOX}.box .vagrant


echo "Building box: ${BOX}"
${VAGRANT} up && ${VAGRANT} package --output ../output/${BOX}.box

if [ $? != 0 ]
then
  echo "Error in box creation. Exiting."
  exit 1
fi


echo "Cleaning up: ${BOX}"
${VAGRANT} destroy -f
