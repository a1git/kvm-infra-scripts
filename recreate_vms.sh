#!/bin/bash
## Sashi Dahal
## For context and background, please visit: https://www.openstackfaq.com/openstack-liberty-private-cloud-howto/
##

for i in {11..20}
do
echo "removing c$i .. "
virsh destroy c${i}
sleep 5s
virsh undefine c${i}
sleep 5s

echo "creating c$i .."

virt-install \
--name c${i} \
--ram 4096 \
--disk path=/dev/cloud/c${i} \
--vcpus 4 \
--os-type linux \
--os-variant=ubuntutrusty \
--mac 52:54:00:11:12:${i} \
--network bridge='os-pxe' --network bridge='os-mgmt' --network bridge='os-stor' --network bridge='os-vlan' --network bridge='os-vxlan' \
--graphics none --console pty,target_type=serial \
--location 'http://nl.archive.ubuntu.com/ubuntu/dists/trusty/main/installer-amd64/' \
--extra-args 'live-installer/net-image=http://10.11.12.2/ubuntu/install/filesystem.squashfs ks=http://10.11.12.2/ksUbuntu.txt ksdevice=bootif biosdevname=0 nosplash nomodeset console=ttyS0,115200n8 serial' \
--noautoconsole
sleep 60s
done
