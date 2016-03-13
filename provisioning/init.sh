#!/bin/sh

config=$1
if [[ "$config" != "headless" ]]; then
    config="gui"
fi

# Install Ansible and its dependencies if it's not installed already.
if [ ! -f /usr/bin/ansible ]; then
    echo "Installing Ansible dependencies and Git."
    sudo apt-get update
    sudo apt-get install -y git ansible
fi

TEMP_HOSTS="/tmp/ansible_hosts"
cp /vagrant/provisioning/inventory/local ${TEMP_HOSTS} && chmod -x ${TEMP_HOSTS}
echo "Running Ansible provisioner defined in Vagrantfile."
ansible-playbook /vagrant/provisioning/${config}.yml -i ${TEMP_HOSTS} --connection=local

