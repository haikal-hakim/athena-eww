#!/bin/bash
BIRTH=$(stat -c %W /)
if [ "$BIRTH" -le 0 ]; then
  echo '{"days": 0}'
  exit 0
fi
NOW=$(date +%s)
DAYS=$(((NOW - BIRTH) / 86400))
echo "{\"days\": $DAYS}"
