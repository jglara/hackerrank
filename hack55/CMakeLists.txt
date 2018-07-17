cmake_minimum_required(VERSION 2.8)

project (minimize_sum)

# Set the project source dir (just convention)
set( CMAKE_SOURCES
  minimize_sum.cc
)

add_executable(${PROJECT_NAME} ${CMAKE_SOURCES})
add_definitions( --std=c++11 -Wall -Wextra -Wpedantic)
