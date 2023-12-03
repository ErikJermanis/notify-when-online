#!/bin/zsh

site=$1
timeStart=$(date +%s)
minutesSeen=0
downMessageDisplayed=0

echo "checking..."

while true
do
  if ping -q -c 2 -W 1 $site > /dev/null 2>&1; then
    echo "----- Site is up! -----"
    break
  else
    if ((downMessageDisplayed == 0)); then
      echo "Site offline, waiting..."
      downMessageDisplayed=1
    fi
    timeNow=$(date +%s)
    timePassed=$((timeNow - timeStart))
    minutesPassed=$((timePassed / 60))
    if ((minutesPassed > minutesSeen)); then
      minutesSeen=$minutesPassed
      if ((minutesPassed < 2)); then
        echo "$minutesPassed minute mark, waiting..."
      else
        echo "$minutesPassed minutes mark, waiting..."
      fi
    fi
  fi
sleep 6
done
