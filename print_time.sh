#!/usr/bin/env bash

[[ -e /tmp/current_time.log ]] && rm -f /tmp/current_time.log

touch /tmp/current_time.log
chmod 644 /tmp/current_time.log

while true; do
    echo "The time is now $(date '+%c')" >> /tmp/current_time.log
    sleep 1
done
