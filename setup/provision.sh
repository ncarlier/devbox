#!/bin/sh

echo "Install user-data..."
cp /vagrant/user-data /var/lib/coreos-vagrant/user-data

echo "Setup shared directory location..."
echo "export SHARED_DIR=/vagrant_data" > /etc/profile.d/vagrant.sh

echo "Creating /opt/{bin,etc} directories..."
mkdir -p /opt/{bin,etc}

echo "Intalling devbox script..."
cp /vagrant/setup/scripts/devbox /opt/bin/ && chmod +x /opt/bin/devbox

echo "Intalling redsocks script..."
cp /vagrant/setup/scripts/redsocks /opt/bin/ && chmod +x /opt/bin/redsocks

echo "Intalling redsocks whitelist..."
cp /vagrant/setup/files/whitelist.txt /opt/etc

echo "Create dev user..."
useradd -u 1000 dev

echo "Fixing premissions of data dir..."
chown -R dev.dev /vagrant_data

