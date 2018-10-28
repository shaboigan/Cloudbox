#!/bin/sh

REPORT=$( ( du -h /mnt/local --max-depth=3 | sort -h | grep -vE 'incomplete|.union|Music|downloads' | sed s:/mnt/local/:: ; du -h /mnt/local --max-depth=4 | sort -h | grep -E 'incomplete' | sed s:/mnt/local/downloads/:: ; du -h /mnt/local --max-depth=5 | grep -E 'sonarr|radarr' | sed s:/mnt/local/downloads/:: ) | sort -h)

/opt/scripts/system/slack_disk.sh "$REPORT"
