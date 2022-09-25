# ROS-tools
Set of Scripts required to install and use ros

## Install Ubuntu 20.04 Focal Version
This script installs ROS Noetic version and can only be installed on a compatible Ubuntu Version

## Installing ROS Noetic on Ubuntu 20.04.x (Focal Fossa)
[_install_ros_noetic.sh_](https://raw.githubusercontent.com/VEEROBOT/ROS-tools/main/install_ros_noetic.sh)

## Install Script
### Install script for installing ROS Noetic on Ubuntu 20 Platform
### To install do the following from your command prompt: 

```
sudo apt-get update
sudo apt-get upgrade
wget https://raw.githubusercontent.com/VEEROBOT/ROS-tools/main/install_ros_noetic.sh
chmod 755 ./install_ros_noetic.sh 
bash ./install_ros_noetic.sh
source ~/.bashrc
```
If rosversion says unknown, make sure you have typed the last line to source the bashrc file. After that it should say Noetic

If the above install fails, please refer to official install guide : http://wiki.ros.org/noetic/Installation/Ubuntu

## Uninstall Script
### Uninstall script for ROS Noetic and ROS Dependancies
```
sudo wget https://raw.githubusercontent.com/VEEROBOT/ROS-tools/main/uninstall_ros_noetic.sh
sudo chmod +x ./uninstall_ros_noetic.sh
bash ./uninstall_ros_noetic.sh
```
Now delete last two sourcing lines from .bashrc file. If not removed, it throws error that /opt... not found

### Install these ROS Packages if required

```
$ sudo apt-get install ros-noetic-joy ros-noetic-teleop-twist-joy \
  ros-noetic-teleop-twist-keyboard ros-noetic-laser-proc \
  ros-noetic-rgbd-launch ros-noetic-depthimage-to-laserscan \
  ros-noetic-rosserial-arduino ros-noetic-rosserial-python \
  ros-noetic-rosserial-server ros-noetic-rosserial-client \
  ros-noetic-rosserial-msgs ros-noetic-amcl ros-noetic-map-server \
  ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro \
  ros-noetic-compressed-image-transport ros-noetic-rqt* \
  ros-noetic-gmapping ros-noetic-navigation ros-noetic-interactive-markers
```  

## Test run : Enter below commands on three different terminals
```
roscore
rosrun roscpp_tutorials talker
rosrun roscpp_tutorials listner
```

### Network Configuration
Connect PC to a WiFi device and find the assigned IP address with the command below
``` ifconfig ```
Open the file and update the ROS IP settings with the command below. 
``` nano ~/.bashrc ```
Modify the address of localhost in the ROS_MASTER_URI and ROS_HOSTNAME with the IP address acquired from the above terminal window. Add the details at the end of the file. Use CTRL + END or ALT + / or move the cursor line by line to end of file
 ```
 export ROS_MASTER_URI = http://<ipaddress_from_above>:11311
 export ROS_HOSTNAME = <ipaddress>
 ```
 Source the bashrc with below command
 ```
 source ~/.bashrc
 ```
