#!/bin/bash
YUBI_DEVICEFILE=$(lsusb -d 1050: | sed -e 's/Bus \([0-9][0-9][0-9]\) Device \([0-9][0-9][0-9]\):.*/ dev bus usb \1 \2/g' | tr ' ' '/')
#GIT_DIR="/home/victor/dev/git"
if [ -z "$YUBI_DEVICEFILE" ]; then
    echo "no yubikey found. stopping."
    exit 1
else
    echo -n "building docker image..."
    #DOCKER_IMAGE_ID=$(docker build . | grep 'Successfully built' | sed -e 's/[a-zA-Z ]\+\([0-9a-fA-F]\+\)/\1/')
    docker build -t yubikey-docker:latest -f Dockerfile .
    echo "running docker with access to yubikey-devicefile $YUBI_DEVICEFILE..."
    docker run -ti --rm --privileged \
    -v /dev/bus/usb:/dev/bus/usb \
    -v /sys/bus/usb/:/sys/bus/usb/ \
    -v /sys/devices/:/sys/devices/ \
    -v $YUBI_DEVICEFILE:$YUBI_DEVICEFILE \
    yubikey-docker:latest
fi

