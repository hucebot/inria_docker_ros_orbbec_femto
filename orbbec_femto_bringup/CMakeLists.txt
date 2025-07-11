cmake_minimum_required(VERSION 2.8.12)
project(orbbec_femto_bringup)

find_package(catkin REQUIRED
)
catkin_package()

add_compile_options(-W -Wall -std=c++17)
 
install(DIRECTORY launch
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
