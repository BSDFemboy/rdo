#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: No parameters given. Please provide a command to run as root."
  exit 1
fi

COMMAND=$1
shift
PARAMS="$@"

tries=0

while true; do
  su root -c "$COMMAND $PARAMS" && break
  tries=$((tries+1))

  if [ $tries -gt 2 ]; then
    echo "Error: Incorrect password. Maximum tries exceeded. Exiting script."
    exit 1
  fi
  echo "Error: Incorrect password. Please try again. You have $((3 - tries)) attempts left."
done
