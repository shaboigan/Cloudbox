#!/bin/bash
#--Mounts local-crypt: to /mnt/.Media
rclone --uid=1000 --gid=1000 --allow-non-empty --allow-other mount local-crypt: /mnt/.local-crypt --bwlimit 8650k --size-only
