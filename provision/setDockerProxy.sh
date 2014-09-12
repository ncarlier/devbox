#!/bin/sh

echo "Setup boot2docker profile..."
for line in $( cat /etc/environment )
do
    echo "export $line" >> /var/lib/boot2docker/profile
done
echo "Rebooting docker..."
/etc/init.d/docker restart

