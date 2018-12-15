#!/bin/sh

CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
PAUSE=90
RESUME=40

# check if a pause command needs to be sent
  if [ "$CURRENT" -ge "$PAUSE" ] ; then
# check if pause lock file exists
    if [ -e /opt/scripts/nzbs/sabnzbd/pause.lock ]; then
        echo "sabnzbd is already paused, exiting"
        exit
    else
# create a pause lock file and remove resume lock file
        touch /opt/scripts/nzbs/sabnzbd/pause.lock && rm /opt/scripts/nzbs/sabnzbd/resume.lock
        /opt/scripts/system/slack_sabnzbd.sh "Running out of space on $(hostname), Currently \"($CURRENT%)\" used as of $(date) - pausing sabnzbd queue" && curl --silent curl https://sabnzbd.getplexd.tv/api -F apikey=43f827362287fb93a6f0994c80c0f740 -F mode=pause
    fi
# check if a resume command needs to be sent
  elif [ "$CURRENT" -le "$RESUME" ] ; then
# check if resume lock file exists
    if [ -e /opt/scripts/nzbs/sabnzbd/resume.lock ]; then
        echo "sabnzbd is already resumed, exiting"
        exit
    else
# create a resume lock file and remove pause lock file
        touch /opt/scripts/nzbs/sabnzbd/resume.lock && rm /opt/scripts/nzbs/sabnzbd/pause.lock
        /opt/scripts/system/slack_sabnzbd.sh "Space available on $(hostname), Currently \"($CURRENT%)\" used as of $(date) - resuming sabnzbd queue" && curl --silent curl https://sabnzbd.getplexd.tv/api -F apikey=43f827362287fb93a6f0994c80c0f740 -F mode=resume
    fi
  fi

