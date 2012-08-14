#!/bin/bash

################################################################################
# Install required software
################################################################################

apt-get install -y wget openssh-server puppet 
# apt-get install -y rubygems
# gem install chef --no-ri --no-rdoc





################################################################################
# Amend root user password
################################################################################

echo 'Changing root password to "vagrant"'
echo -e "vagrant\nvagrant\n" | passwd root
echo





################################################################################
# Set machine name - this doesn't stick?
################################################################################

echo 'Setting hostname and domainname'
hostname vagrant-precise64
domainname vagrantup.com
echo




################################################################################
# Add vagrant user
################################################################################

if [ ! $(grep '^admin' /etc/group) ]
then
  echo 'Adding admin group'
  groupadd admin
fi


echo 'Adding vagrant user in admin group'
useradd -g users -G admin -s /bin/bash -m vagrant
echo

echo 'Changing vagrant password to "vagrant"'
echo -e "vagrant\nvagrant\n" | passwd vagrant
echo

echo 'Updating path for vagrant user'
echo 'export PATH=$PATH:/usr/sbin:/sbin' >> /home/vagrant/.bashrc
echo

echo 'Adding vagrant ssh keys'
mkdir /home/vagrant/.ssh
chmod 755 /home/vagrant/.ssh
wget http://raw.github.com/mitchellh/vagrant/master/keys/vagrant
mv vagrant /home/vagrant/.ssh
wget http://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub 
mv vagrant.pub /home/vagrant/.ssh/authorized_keys
chmod 644 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
   
   



################################################################################
# /etc/sudoers
################################################################################

echo 'Amending /etc/sudoers for vagrant use'
grep -v '^admin' /etc/sudoers | grep -v 'env_keep' > /tmp/sudoers
mv /tmp/sudoers /etc/sudoers
echo  -e '\n%admin\tALL=(ALL)\tNOPASSWD: ALL' >> /etc/sudoers
echo -e 'Defaults\tenv_keep="SSH_AUTH_SOCK"\n' >> /etc/sudoers

service sudo restart







################################################################################
# Install Guest Additions
################################################################################

# Needs the Guest Additions loaded?

# HostKey + F to go fullscreen, makes menus available.
# HostKey + D to add Guest Additions or
# From Devices, choose CD-ROM/DVD and add image at /usr/share/virtualbox/

echo 'Installing Guest Additions'
apt-get install linux-headers-$(uname -r) build-essential
mkdir /tmp/cdrom
mount /dev/cdrom /tmp/cdrom
/tmp/cdrom/VBoxLinuxAdditions.run




################################################################################
# Finish up
################################################################################

echo 'Cleaning up'
apt-get clean

#rm -r "$(gem env gemdir)"/doc/*

echo 'Package with e.g.: vagrant package --base test --output test.box'




exit 0
