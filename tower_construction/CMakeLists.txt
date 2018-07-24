cmake_minimum_required(VERSION 2.8)

project (tower_construction)

# Set the project source dir (just convention)
set( CMAKE_SOURCES
  tower_construction.cc
)

add_executable(${PROJECT_NAME} ${CMAKE_SOURCES})
add_definitions( --std=c++11 -Wall -Wextra -Wpedantic)