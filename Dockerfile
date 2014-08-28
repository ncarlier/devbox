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
run apt-get install -y vim tmux zsh git curl wget sudo

# Install the latest version of the docker CLI
run curl -L -o /usr/local/bin/docker https://get.docker.io/builds/Linux/x86_64/docker-latest && \
    chmod +x /usr/local/bin/docker

# Setup home environment
run useradd dev
run mkdir /home/dev && chown -R dev: /home/dev
env HOME /home/dev
env PATH $HOME/bin:$PATH

# Create src data volume
# We need to create an empty file, otherwise the volume will belong to root.
run mkdir /var/shared/
run touch /var/shared/placeholder
run chown -R dev:dev /var/shared
volume /var/shared

# Setup working directory
workdir /home/dev

# Run everything below as the dev user
user dev

# Link in shared parts of the home directory
run ln -s /var/shared/.ssh && \
    ln -s /var/shared/.vim && \
    ln -s /var/shared/.vimrc && \
    ln -s /var/shared/.git && \
    ln -s /var/shared/.gitconfig && \
    ln -s /var/shared/.gitmodules && \
    ln -s /var/shared/.tmux.conf && \
    ln -s /var/shared/.zshrc && \
    ln -s /var/shared/src

# Install oh my zsh
run git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

entrypoint ["/bin/zsh", "-i"]
