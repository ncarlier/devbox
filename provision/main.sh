#!/bin/sh

echo "Setup shared directory location..."
echo "export SHARED_DIR=/vagrant_data" > /etc/profile.d/vagrant.sh

echo "Copy devbox script..."
cp /vagrant/bin/devbox /usr/local/bin/devbox
