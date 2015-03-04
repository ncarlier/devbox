# Automatically replace the discovery token on 'vagrant up'
if !File.exists?('token') && ARGV[0].eql?('up')
  require 'open-uri'
  require 'yaml'

  token = open('https://discovery.etcd.io/new').read
  File.open('token', 'w') { |file| file.write("#{token}") }

  data = YAML.load(IO.readlines('user-data')[1..-1].join)
  data['coreos']['etcd']['discovery'] = token

  yaml = YAML.dump(data)
  File.open('user-data', 'w') { |file| file.write("#cloud-config\n\n#{yaml}") }
end

# Size of the CoreOS cluster created by Vagrant
$num_instances=1

# Official CoreOS channel from which updates should be downloaded
$update_channel='beta'

# Setting for VirtualBox VMs
$vb_gui = false

# Other settings...
$memory = 1024
$cpus = 1
