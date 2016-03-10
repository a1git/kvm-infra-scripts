## Sashi Dahal
## For context and background, please visit: https://www.openstackfaq.com/openstack-liberty-private-cloud-howto/
##

## create 3 data nodes with 4 CPU, 4GB RAM  each ##
for i in {11..13}
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
--network bridge='br-pxe' --network bridge='br-mgmt' --network bridge='br-stor' --network bridge='br-vlan' --network bridge='br-vxlan' \
--graphics none --console pty,target_type=serial \
--location 'http://nl.archive.ubuntu.com/ubuntu/dists/trusty/main/installer-amd64/' \
--extra-args 'live-installer/net-image=http://10.11.12.2/ubuntu/install/filesystem.squashfs ks=http://10.11.12.2/ksUbuntu.txt ksdevice=bootif biosdevname=0 nosplash nomodeset console=ttyS0,115200n8 serial' \
--noautoconsole
sleep 60s
done

## create 3 controller nodes with 8 CPU, 16GB RAM each ##
for i in {14..16}
do
echo "removing c$i .. "
virsh destroy c${i}
sleep 5s
virsh undefine c${i}
sleep 5s

echo "creating c$i .."

virt-install \
--name c${i} \
--ram 16384 \
--disk path=/dev/cloud/c${i} \
--vcpus 8 \
--os-type linux \
--os-variant=ubuntutrusty \
--network bridge='br-pxe' --network bridge='br-mgmt' --network bridge='br-stor' --network bridge='br-vlan' --network
 bridge='br-vxlan' \
--graphics none --console pty,target_type=serial \
--location 'http://nl.archive.ubuntu.com/ubuntu/dists/trusty/main/installer-amd64/' \
--extra-args 'live-installer/net-image=http://10.11.12.2/ubuntu/install/filesystem.squashfs ks=http://10.11.12.2/ksUbuntu.txt ksdevice=bootif biosdevname=0 nosplash nomodeset console=ttyS0,115200n8 serial' \
--noautoconsole
sleep 60s
done


## create 9 more nodes with  4 CPU, 4GB RAM each - for compute, network, ceph, swift ##
for i in {17..25}
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
--network bridge='br-pxe' --network bridge='br-mgmt' --network bridge='br-stor' --network bridge='br-vlan' --network
 bridge='br-vxlan' \
--graphics none --console pty,target_type=serial \
--location 'http://nl.archive.ubuntu.com/ubuntu/dists/trusty/main/installer-amd64/' \
--extra-args 'live-installer/net-image=http://10.11.12.2/ubuntu/install/filesystem.squashfs ks=http://10.11.12.2/ksUbuntu.txt ksdevice=bootif biosdevname=0 nosplash nomodeset console=ttyS0,115200n8 serial' \
--noautoconsole
sleep 60s
done

