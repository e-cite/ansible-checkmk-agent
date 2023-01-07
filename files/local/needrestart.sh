#!/bin/bash
# -lkw -> libraries, kernel + CPU microcode
# -p NAGIOS output - needs to be rearranged for checkmk and put in one line
NEEDRESTART=$(sudo needrestart -lkwp | awk -v ORS='\\n' '1')
STATE=$(echo $NEEDRESTART | awk '{print $1}') #echo $NEEDRESTART  | sed 's/WARN/1/' | sed 's/- \([^|]*\)\(\|.*;[0-9]\+\)/NEEDRESTART \2 \1/' | sed 's/\|\([^\s]\+\)
METRICS=$(echo $NEEDRESTART | sed 's/^[^|]*|\(.*;[0-9]\+\)\\n.*/\1/' | sed 's/ /|/g' )
OUTPUT=$(echo $NEEDRESTART | sed 's/^.*- \([^|]*\)|.*;[0-9]\+\(\\n.*\)/\1\2/')

if [ "$STATE" == "WARN" ];then
  STATE="1"
elif [ "$STATE" == "CRIT" ];then
  STATE=2
elif [ "$STATE" == "OK" ];then
  STATE=0
fi

echo "$STATE NEEDRESTART $METRICS $OUTPUT"
