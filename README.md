# ROS-tools
Set of Scripts required to install and use ros

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
```

### Single Line Install
```
wget -c https://raw.githubusercontent.com/VEEROBOT/ROS-tools/main/install_ros_noetic.sh && chmod +x ./install_ros_noetic.sh && ./install_ros_noetic.sh
```
If the above install fails, please refer to official install guide : http://wiki.ros.org/noetic/Installation/Ubuntu

## Uninstall Script
### Uninstall script for ROS Noetic and ROS Dependancies. Does not remove python and other non ros packages
```
wget https://raw.githubusercontent.com/VEEROBOT/ROS-tools/main/uninstall_ros_noetic.sh
chmod 755 ./uninstall_ros_noetic.sh
bash ./uninstall_ros_noetic.sh
```
### Single Line Uninstall

```
wget -c https://raw.githubusercontent.com/VEEROBOT/ROS-tools/main/uninstall_ros_noetic.sh && chmod +x ./uninstall_ros_noetic.sh && ./uninstall_ros_noetic.sh
```

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
