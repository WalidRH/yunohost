# yunohost
YunoHost is an operating system aiming for the simplest administration of a server, and therefore democratize self-hosting, while making sure it stays reliable, secure, ethical and lightweight. It is a copylefted libre software project maintained exclusively by volunteers. Technically, it can be seen as a distribution based on Debian GNU/Linux and can be installed on many kinds of hardware.
[check intro & doc of yunohost](https://yunohost.org/en/whatsyunohost)

## Install Yunohost
There are some images of yunohost in the [installation guide](https://yunohost.org/en/install/hardware:regular), you may use them, but they aren't up to date and sometimes the installation may be complicated and failed. I personnaly prefer to install a debian operating system; [Debian 10 (buster)](https://www.debian.org/releases/buster/debian-installer/). And then follow the installation guide in [this section](https://yunohost.org/en/install/hardware:vps_debian)

## scripts used 
*   dns script: I used [Duck DNS](https://www.duckdns.org), to configure DNS for my server, and used duckdns.sh script in cron to reset a public ip adress to my dns domain
*   disk_detector: this script detects and mount USB sticks and hard drives.
