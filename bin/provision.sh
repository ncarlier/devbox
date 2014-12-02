#!/bin/sh

echo "Setup shared directory location..."
echo "export SHARED_DIR=/vagrant_data" > /etc/profile.d/vagrant.sh

echo "Creating /opt/bin directory..."
mkdir -p /opt/bin

echo "Intalling devbox script..."
mv /tmp/devbox /opt/bin/ && chmod +x /opt/bin/devbox

echo "Intalling redsocks script..."
mv /tmp/redsocks /opt/bin/ && chmod +x /opt/bin/redsocks

echo "Create dev user..."
sudo useradd -u 1000 dev

echo "Fixing premissions of data dir..."
sudo chown -R dev.dev /vagrant_data

