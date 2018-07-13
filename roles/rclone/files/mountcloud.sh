#!/bin/bash
#--Mounts cloud-crypt: to /mnt/.cloud-crypt
rclone --uid=1000 --gid=1000 --allow-non-empty --allow-other mount cloud-crypt: /mnt/.cloud-crypt --bwlimit 8650k --size-only
