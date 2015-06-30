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
- Intellij IDEA 14 Community
- Virtual Box Additions

> Note: GUI setup is not available with the Docker image

## Virtual Machine

### Prerequisite

1. [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
2. [Vagrant](https://docs.vagrantup.com/v2/installation/index.html)
3. Install vagrant proxy conf plugin (if you are behind a corporate proxy)
  ```
  vagrant plugin install vagrant-proxyconf
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

```
./devbox

# OR

docker run --name="devbox" -h "devbox" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -it \
  ncarlier/devbox
```

Done.
