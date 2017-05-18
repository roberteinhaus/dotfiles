#!/bin/sh
DIR="$( cd "$( dirname "$0" )" && pwd )"
if [ $# -eq 0 ]; then
    time=1500
else
    time=${1}
fi
clear
tput civis
date1=$((`date +%s` + ${time}))
while [ "$date1" -gt `date +%s` ]; do
    sleep 0.1
    tput cup 1
    figlet -k -f big "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)        "
    echo "ð $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S) " > ~/.pomodoro
done
tput cup 1
figlet -k -f big "Finished!          "
tput cnorm
echo "" > ~/.pomodoro

cat ${DIR}/ding.wav > /dev/dsp
