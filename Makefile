.SILENT :
.PHONY : build clean cleanup start

USERNAME:=ncarlier
APPNAME:=devbox
IMAGE:=$(USERNAME)/$(APPNAME)

all: build

build:
	echo "Building $(IMAGE) docker image..."
	docker build --rm -t $(IMAGE) .

clean:
	echo "Removing $(IMAGE) docker image..."
	-docker rmi $(IMAGE)

cleanup:
	echo "Removing dangling docker images..."
	-docker images -q --filter 'dangling=true' | xargs sudo docker rmi

start:
	./devbox

