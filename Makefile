.SILENT :
.PHONY : build clean cleanup run

USERNAME:=ncarlier
APPNAME:=devbox
IMAGE:=$(USERNAME)/$(APPNAME)

all: build

build:
	echo "Building $(IMAGE) docker image..."
	sudo docker build --rm -t $(IMAGE) .

clean:
	echo "Removing $(IMAGE) docker image..."
	-sudo docker rmi $(IMAGE)

cleanup:
	echo "Removing dangling docker images..."
	-sudo docker images -q --filter 'dangling=true' | xargs sudo docker rmi

run:
	sudo bin/devbox

