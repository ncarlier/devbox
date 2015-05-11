# -*- mode: ruby -*-
# # vi: set ft=ruby :

require 'fileutils'

Vagrant.require_version ">= 1.6.0"

CONFIG = File.join(File.dirname(__FILE__), "config.rb")
PROVISION_SCRIPT = File.join(File.dirname(__FILE__), "setup", "provision.sh")

# Defaults for config options defined in CONFIG
$num_instances = 1
$update_channel = "alpha"
$vb_gui = false
$vb_memory = 1024
$vb_cpus = 1
$expose_docker_tcp = false

# Attempt to apply the deprecated environment variable NUM_INSTANCES to
# $num_instances while allowing config.rb to override it
if ENV["NUM_INSTANCES"].to_i > 0 && ENV["NUM_INSTANCES"]
  $num_instances = ENV["NUM_INSTANCES"].to_i
end

if File.exist?(CONFIG)
  require CONFIG
end

Vagrant.configure("2") do |config|
  config.vm.box = "coreos-%s" % $update_channel
  config.vm.box_version = ">= 584.0.0"
  config.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json" % $update_channel

  config.vm.provider :libvirt do |vb, override|
    override.vm.box = "coreos_production_vagrant"
    override.vm.box_version =">= 0"
    override.vm.box_url = ""
  end

  config.vm.provider :virtualbox do |v|
    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in CoreOS, so tell Vagrant that so it can be smarter.
    v.check_guest_additions = false
    v.functional_vboxsf     = false
  end

  # plugin conflict
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  (1..$num_instances).each do |i|
    config.vm.define vm_name = "devbox-%02d" % i do |config|
      config.vm.hostname = vm_name

      if $expose_docker_tcp
        config.vm.network "forwarded_port", guest: 2375, host: ($expose_docker_tcp + i - 1), auto_correct: true
      end

      config.vm.provider :virtualbox do |vb|
        vb.gui = $vb_gui
        vb.memory = $vb_memory
        vb.cpus = $vb_cpus
      end
      config.vm.provider :libvirt do |domain|
        domain.memory = $memory
        domain.cpus = $cpus
      end

      ip = "192.168.91.#{i+100}"
      config.vm.network :private_network, ip: ip

      config.vm.synced_folder ".", "/vagrant", type: "rsync"

      # Share home directory with the VM
      config.vm.synced_folder "~/", "/vagrant_data",
        owner: "dev", group:"dev",
        type: "rsync", rsync__exclude: "VirtualBox\ VMs/"

      # Run provisioning
      config.vm.provision :shell, path: "#{PROVISION_SCRIPT}", :privileged => true
    end
  end
end
