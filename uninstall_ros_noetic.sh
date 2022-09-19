#!/bin/bash
# Apache License 2.0
# Copyright (c) 2022, Siliris Technologies Pvt. Ltd. 

#set -x	# enable debugging
#set +x	# disable debugging

echo ""
echo "[Uninstalling ROS Noetic Installation from your system]"
echo ""
echo "[This will take a few minutes to complete]"
echo ""
sudo apt-get purge ros-*
echo ""
echo "[Auto removing dependent packages]"
sudo apt-get autoremove
echo ""
echo "[Uninstall Done: ROS Noetic & Dependant packages]"
