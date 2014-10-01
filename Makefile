.SILENT :
.PHONY : build clean run

USERNAME:=ncarlier
APPNAME:=devbox
IMAGE:=$(USERNAME)/$(APPNAME)

all: build

build:
	echo "Building $(IMAGE) docker image..."
	sudo docker build --rm -t $(IMAGE) .

clean:
	echo "Removing $(IMAGE) docker image..."
	sudo docker rmi $(IMAGE)

run:
	sudo bin/devbox

