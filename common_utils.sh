#!/usr/bin/env bash

chkRoot() {
# Check if running as root
# If not, ask for root password
if [ "$(id -u)" != 0 ]
then
  sudo bash "$0"
  exit 1
fi
}

successFail() {
if [ $? -eq 0 ]
then
	echo -e "\nDone.\n"
else
	echo -e "\nSome error occurred performing the task.\n"
	exit 1
fi
}