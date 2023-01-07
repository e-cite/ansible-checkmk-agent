#!/bin/bash
# -lkw -> libraries, kernel + CPU microcode
# -p NAGIOS output - needs to be rearranged for checkmk and put in one line
NEEDRESTART=$(sudo needrestart -lkwp | awk -v ORS='\\n' '1')
RESULT=$(echo $NEEDRESTART | awk '{print $1}') #echo $NEEDRESTART  | sed 's/WARN/1/' | sed 's/- \([^|]*\)\(\|.*;[0-9]\+\)/NEEDRESTART \2 \1/' | sed 's/\|\([^\s]\+\)
METRICS=$(echo $NEEDRESTART | sed 's/^[^|]*|\(.*;[0-9]\+\)\\n.*/\1/' | sed 's/ /|/g' )
OUTPUT=$(echo $NEEDRESTART | sed 's/^.*- \([^|]*\)|.*;[0-9]\+\(\\n.*\)/\1\2/')

if [ "$RESULT" == "WARN" ]; then
  STATE="1"
elif [ "$RESULT" == "CRIT" ]; then
  STATE=2
elif [ "$RESULT" == "OK" ]; then
  STATE=0
else
  STATE=3
fi

echo "$STATE NEEDRESTART $METRICS $OUTPUT"
