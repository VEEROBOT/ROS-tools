#!/bin/bash
# Apache License 2.0
# Copyright (c) 2022, Siliris Technologies Pvt. Ltd. 

name_ros_distro=noetic 
user_name=$(whoami)

echo ""
echo "[Starting ROS Noetic Installation]"
echo "[Note] Target OS version  >>> Ubuntu 20.04.x (Focal Fossa) or Linux Mint 21.x"
echo "[Note] Target ROS version >>> ROS Noetic Ninjemys"
echo "[Note] Catkin workspace   >>> $HOME/catkin_ws"
echo ""

#Getting version and release number of Ubuntu
echo ""
echo "[Checking your Ubuntu version] "
version=`lsb_release -sc`
relesenum=`grep DISTRIB_DESCRIPTION /etc/*-release | awk -F 'Ubuntu ' '{print $2}' | awk -F ' LTS' '{print $1}'`
echo "[Your Ubuntu version is: (Ubuntu $version $relesenum)]"
#Checking version is focal, if yes proceed othervice quit
case $version in
  "focal" )
  ;;
  *)
    echo ">>> [ERROR: This script will only work on Ubuntu Focal (20.04).]"
    exit 0
esac

echo "This is a compatible version of Ubuntu for ROS Noetic"
echo "[Setting the target OS, ROS version and name of catkin workspace]"
name_os_version=${name_os_version:="focal"}
name_ros_version=${name_ros_version:="noetic"}
name_catkin_workspace=${name_catkin_workspace:="catkin_ws"}

echo "[Updating the packages]"
sudo apt update -y

echo ""
echo "[Configuring Ubuntu repositories]"
echo ""
sudo add-apt-repository universe
sudo add-apt-repository restricted
sudo add-apt-repository multiverse

echo ""
echo "[Done: Added Ubuntu repositories]"
echo ""

echo "[Install build environment, the chrony, ntpdate and set the ntpdate]"
sudo apt install -y chrony ntpdate curl build-essential
sudo ntpdate ntp.ubuntu.com

echo "[Adding the ROS repository]"
if [ ! -e /etc/apt/sources.list.d/ros-latest.list ]; then
  sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu ${name_os_version} main\" > /etc/apt/sources.list.d/ros-latest.list"
fi

echo "[Installing curl and Setting up ROS keys]"
sudo apt install curl

echo "[This will take a few seconds for adding keys]"
ret=$(curl -s 'https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc' | sudo apt-key add -)
#Checking return value is OK
case $ret in
  "OK" )
  ;;
  *)
    echo "[Failed to receive ROS keys, aborting the installation]"
    exit 0
esac

echo "[ROS Keys added]"

echo "[Update the package lists]"
echo "[This process will take time depending on your network speed]"

sudo apt update -y

echo ""
echo "[Pick the version of ROS you would like to Install. Default is Desktop-Full]"
echo "     [1. Desktop-Full Install: (Recommended) : Everything in Desktop plus 2D/3D simulators and 2D/3D perception packages ]"
echo ""
echo "     [2. Desktop Install: Everything in ROS-Base plus tools like rqt and rviz]"
echo ""
echo "     [3. ROS-Base: (Bare Bones) ROS packaging, build, and communication libraries. No GUI tools.]"
echo ""

read -p "Enter your choice (Default is 1):" answer 
#Default value is 1: Desktop full install
case "$answer" in
  1)
    package_type="desktop-full"
    ;;
  2)
    package_type="desktop"
    ;;
  3)
    package_type="ros-base"
    ;;
  * )
    package_type="desktop-full"
    ;;
esac	

echo ""
echo "[Starting ROS installation, this will really take some time. A mug of might help you!]"

sudo apt-get install -y ros-${name_ros_distro}-${package_type} 

if [[ package_type == "desktop-full" || package_type == "desktop" ]]; then
echo "[Installing RQT & Gazebo]"
sudo apt install -y ros-$name_ros_version-rqt-* ros-$name_ros_version-gazebo-*
fi

echo "[Environment setup and getting rosinstall]"
source /opt/ros/$name_ros_version/setup.bash
sudo apt install -y python3-rosinstall python3-rosinstall-generator python3-wstool build-essential git

echo "[Install rosdep and Update]"
sudo apt install python3-rosdep

echo "[Initialize rosdep and Update]"
sudo sh -c "rosdep init"
rosdep update

echo "[Make the catkin workspace and test the catkin_make]"
mkdir -p $HOME/$name_catkin_workspace/src
cd $HOME/$name_catkin_workspace/src
catkin_init_workspace
cd $HOME/$name_catkin_workspace
catkin_make

echo "[Setting up the ROS evironment]"
sh -c "echo \"alias eb='nano ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias sb='source ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias gs='git status'\" >> ~/.bashrc"
sh -c "echo \"alias gp='git pull'\" >> ~/.bashrc"
sh -c "echo \"alias cw='cd ~/$name_catkin_workspace'\" >> ~/.bashrc"
sh -c "echo \"alias cs='cd ~/$name_catkin_workspace/src'\" >> ~/.bashrc"
sh -c "echo \"alias cm='cd ~/$name_catkin_workspace && catkin_make'\" >> ~/.bashrc"

sh -c "echo \"source /opt/ros/$name_ros_version/setup.bash\" >> ~/.bashrc"
sh -c "echo \"source ~/$name_catkin_workspace/devel/setup.bash\" >> ~/.bashrc"

sh -c "echo \"export ROS_MASTER_URI=http://localhost:11311\" >> ~/.bashrc"
sh -c "echo \"export ROS_HOSTNAME=localhost\" >> ~/.bashrc"

echo ""
echo ""

echo "[Sourcing bashrc]"
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

echo ""
echo "[ROS Noetic Installation Complete - Siliris Technologies Pvt. Ltd!]"
echo "[Type [ rosversion -d ] to get the current ROS installed version]"
exit 0
