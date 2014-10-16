# Node.JS docker image.
#
# VERSION 0.0.1
#
# BUILD-USING: docker build --rm --no-cache -t ncarlier/devbox .

from debian:jessie

maintainer Nicolas Carlier <https://github.com/ncarlier>

env DEBIAN_FRONTEND noninteractive

# Update distrib
run apt-get update && apt-get upgrade -y

# Install packages
run apt-get install -y man vim tmux zsh git curl wget sudo ca-certificates build-essential corkscrew dnsutils

# Install the latest version of the docker CLI
run curl -L -o /usr/local/bin/docker https://get.docker.io/builds/Linux/x86_64/docker-latest && \
    chmod +x /usr/local/bin/docker

# Allow dev user to use docker
run echo "dev    ALL=NOPASSWD: /usr/local/bin/docker" > /etc/sudoers.d/docker

# Install the latest version of fleetctl
env FLEET_URL https://github.com/coreos/fleet/releases/download/v0.8.3/fleet-v0.8.3-linux-amd64.tar.gz
run (cd /tmp && wget $FLEET_URL -O fleet.tgz && tar zxf fleet.tgz && mv fleet-*/fleetctl /usr/local/bin/)

# Install the latest version of Go
env GO_URL https://storage.googleapis.com/golang/go1.3.1.linux-amd64.tar.gz
run (cd /tmp && curl -L -o go.tgz $GO_URL && tar -v -C /usr/local -xzf go.tgz)
env GOROOT /usr/local/go/
env GOPATH /home/dev/go
env PATH $PATH:$GOROOT/bin:$GOPATH/bin

# Setup dev user environment
run useradd dev -s /bin/zsh
run mkdir /home/dev && chown -R dev: /home/dev
env HOME /home/dev
env PATH $HOME/bin:$PATH

# Create src data volume
# We need to create an empty file, otherwise the volume will belong to root.
run mkdir /var/shared/ && touch /var/shared/placeholder && chown -R dev:dev /var/shared
volume /var/shared

# Setup working directory
workdir /home/dev

# Cleanup
run rm -rf /tmp/* && apt-get clean

# Run everything below as the dev user
user dev

# Install dotfiles
run git clone git://github.com/ncarlier/dotfiles.git ~/

# Link in shared parts of the home directory
run ln -fs /var/shared/.ssh && \
    ln -fs /var/shared/.gitconfig && \
    ln -fs /var/shared/src

# Install oh my zsh
run git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

entrypoint ["/usr/bin/ssh-agent", "/bin/zsh"]
