# Devbox

## Description

My dev box running on Virtual Box, Docker or bare metal..

Headless setup:

- Users from GitHub (see group_vars/local to change users)
- Ansible (also used for the provisioning)
- Vim
- SSH
- Docker and Docker Compose
- OpenJDK 8
- NodeJS
- Go
- Python

GUI setup:

- Headless setup, plus...
- XFCE 4
- Chromium
- Virtual Box Additions

> Note: GUI setup is not available with the Docker image

## Virtual Machine

### Prerequisite

1. [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
2. [Vagrant](https://docs.vagrantup.com/v2/installation/index.html)
3. Install vagrant proxy conf plugin (if you are behind a corporate proxy)
  ```
  vagrant plugin install vagrant-proxyconf
  vagrant plugin install vagrant-persistent-storage
  ```
  Edit your global Vagrantfile (located in the .vagrant.d directory of your home directory):

  ```
  Vagrant.configure("2") do |config|
    if Vagrant.has_plugin?("vagrant-proxyconf")
      config.proxy.http     = "http://proxy-internet.localnet:3128/"
      config.proxy.https    = "http://proxy-internet.localnet:3128/"
      config.proxy.no_proxy = "localhost,.priv.corp.com"
    end
  end
  ```

### Usage

Start the VM with Vagrant:

```
vagrant up
```

## Docker

### Usage

Start the container with Docker:

```bash
./devbox

# OR

docker run --name="devbox" -h "devbox" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -it \
  ncarlier/devbox
```

## Remaining work

### Vagrant persitent disk

If you want to use a persistent disk for your home directory there is some manual work to do:

```bash
# SSH into the VM
vagrant ssh
# Swith to root user
sudo -s
# Unmount the persistent disk
umount /mnt/home/
# Build the partition
cfdisk /dev/sdb
# Make the file system
mkfs.btrfs /dev/sdb1
# Remount the partition
mount -a
# Copy all current home data to the new location
cp -rp /home/* /mnt/home/
# Edit the fstab
vi /etc/fstab
# Update the last line as follow:
# /dev/sdb1 /home btrfs defaults 0 0

# Reboot
```

### Dotfiles

If you are using my dotfiles you have to start the install script:

```bash
# If you are behind a corporate proxy
. /etc/profile.d/proxy.sh
cd .dotfiles
./install
```

### Proxy

If your are behind a corporate proxy and you are using ZSH you may have to do this:

```bash
echo "source /etc/profile.d/proxy.sh" > .localrc
```

If you want to use docker without having struggle with the proxy, you just have to do this:

```bash
redsocks start
```

### SSL

If you have troubles with ssl handshake you may have to do this:

```bash
sudo update-ca-certificates -f
```


Enjoy.
