cmake_minimum_required(VERSION 3.16)

project(lru)

add_executable(lru main.cpp)
set_target_properties(lru PROPERTIES
  CXX_STANDARD 14
  CXX_STANDARD_REQUIRED YES)
target_compile_options(lru PRIVATE -Wall -Wextra -pedantic -g)

