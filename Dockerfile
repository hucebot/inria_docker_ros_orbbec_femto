#FROM nvidia/opengl:1.2-glvnd-devel-ubuntu22.04
FROM nvidia/opengl:1.2-glvnd-devel-ubuntu20.04

#System full upgrade
RUN apt-get update && apt-get --with-new-pkgs upgrade -y

#Essential packages
RUN apt-get update && apt-get install -y apt-utils
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris
RUN apt-get update && apt-get install -y --fix-missing \
    git vim curl build-essential zlib1g-dev libx11-dev libusb-1.0-0-dev freeglut3-dev liblapacke-dev \
    unzip libopenblas-dev libatlas-base-dev cmake make lsb-release tree \
    sudo ca-certificates gnupg-agent libssl-dev apt-transport-https \
    software-properties-common usbutils mesa-utils mesa-va-drivers vainfo \
    python3-pip python3-numpy libeigen3-dev libgflags-dev libdw-dev \
    libv4l-dev v4l-utils wget curl libnuma-dev libnuma1 libgles2-mesa python3-pykdl

RUN pip install colorama

#Install ROS
RUN \
    echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    apt-get update
RUN apt-get update && apt-get -y -o Dpkg::Options::="--force-overwrite" dist-upgrade
RUN apt-get update && apt-get install -y \
    ros-noetic-catkin python3-catkin-tools ros-noetic-ros-base ros-noetic-geometry-msgs \
    ros-noetic-common-msgs ros-noetic-roscpp ros-noetic-realtime-tools ros-noetic-tf2 ros-noetic-tf2-ros\
    ros-noetic-cv-bridge ros-noetic-rviz  ros-noetic-image-geometry ros-noetic-camera-info-manager \
    ros-noetic-image-transport-plugins ros-noetic-compressed-image-transport \
    ros-noetic-image-transport ros-noetic-image-publisher libgoogle-glog-dev \
    ros-noetic-diagnostic-updater ros-noetic-diagnostic-msgs ros-noetic-rqt-image-view
    

#Install OpenCV
RUN apt-get update && apt-get install -y libopencv-dev libopencv-core-dev opencv-data

#Setup catkin workspace
RUN mkdir -p /root/catkin_ws/src && \
    /bin/bash -c \
    "source /opt/ros/*/setup.bash && \
    cd /root/catkin_ws && catkin init && \
    catkin config --extend /opt/ros/noetic --install -DCMAKE_BUILD_TYPE=Release"
WORKDIR /root/catkin_ws
RUN echo "source /root/catkin_ws/install/setup.bash" >> /root/.bashrc

# Clone 
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/orbbec/OrbbecSDK_ROS1.git
WORKDIR /root/catkin_ws/src/OrbbecSDK_ROS1
RUN git checkout v2-main

#Precompilation
WORKDIR /root/catkin_ws
RUN catkin build

