#!/usr/bin/env bash

source ./common_utils.sh

chkRoot

echo "Installing ..."
cp timer.sh /usr/bin/timer
successFail

echo "Fixing permissions ..."
chmod +x /usr/bin/timer
successFail

exit 0