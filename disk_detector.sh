#!/bin/bash
sudo blkid -s LABEL > /root/disk_detector/list_disks.txt
# remove main disks
sed '/boot\|rootfs/d' /root/disk_detector/list_disks.txt > /root/disk_detector/test.txt
cat /root/disk_detector/test.txt > /root/disk_detector/list_disks.txt
date=$(date +%F_%H-%M-%S)
echo "$date -- Start_-_-_-_--_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_--_-_-_-_-_-_-_-_" >> /var/log/disk_mount.log
while read line
do
	if [ `echo $line | grep -wc "LABEL" ` -gt 0 ]
	then
    disk_location=$(echo $line | cut -d ":" -f1)
    disk_name=$(echo $line | cut -d "=" -f2)
	disk_name=$(echo -e "$disk_name" | tr -d '[:space:]')
	disk_name=$(echo "$disk_name" | xargs)
		if [ `ls /home/admin/media/ | grep -wc $disk_name ` -eq 0 ]
		then
			echo "$date:	 Creating New Dir" >> /var/log/disk_mount.log
			mkdir -m 777 -p /home/admin/media/$disk_name >> /var/log/disk_mount.log 2>&1
		fi
    disk_uuid=$(sudo blkid -s UUID $disk_location | cut -d '"' -f2)
    disk_type=$(sudo blkid -s TYPE $disk_location | cut -d '"' -f2)
	echo "$date:   disk_name ($disk_name) | disk_uuid ($disk_uuid) | disk_type ($disk_type)" >> /var/log/disk_mount.log
		if [ `echo $disk_type ` = "ntfs" ]
		then		
				umount -lf /home/admin/media/$disk_name
				mount -U $disk_uuid -t ntfs-3g -o rw,uid=home,gid=home,umask=000 /home/admin/media/$disk_name >> /var/log/disk_mount.log 2>&1
		else
				mount -U $disk_uuid -t $disk_type -o rw,uid=home,gid=home,umask=000  /home/admin/media/$disk_name >> /var/log/disk_mount.log 2>&1
		fi
    fi
done < /root/disk_detector/list_disks.txt
mount -a
echo "$date -- END -_-_-_--_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_--_-_-_-_-_-_-_-_" >> /var/log/disk_mount.log
