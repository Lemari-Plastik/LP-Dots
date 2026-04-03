#!/bin/bash

HOUR=$(date +%H)
USER_NAME=$(whoami)

if [ $HOUR -lt 12 ]; then
    GREET="Good Morning"
elif [ $HOUR -lt 18 ]; then
    GREET="Good Afternoon"
else
    GREET="Good Night"
fi

echo "$GREET $USER_NAME."