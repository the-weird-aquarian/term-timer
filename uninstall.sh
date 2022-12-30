#!/usr/bin/env bash

chkRoot

if [ -f /usr/bin/timer ]
then
  echo "Uninstalling ..."
  rm /usr/bin/timer
  successFail
else
  echo "File doesn't exist"
fi

exit 0