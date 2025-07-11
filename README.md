# inria_docker_ros_orbbec_femto

Docker container for running Orbbec Femto Bolt cameras in ROS Noetic

## Usage

- Build: `bash build.sh'
- Run the container: 'bash launch.sh'
- Compile inside the container `catkin build && source devel/setup.bash`
- Launch cameras, e.g.: `roslaunch orbbec_femto_bringup launch_femto_bolt.launch`

## Notes

- In case you need to set up udev rules, run `bash orbbec_femto_bringup/utils/install_udev_rules.sh` on your host machine.

T- o identify the serial nummbers of your cameras, run `bash orbbec_femto_bringup/list_ob_devices.sh`.
