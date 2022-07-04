cmake_minimum_required(VERSION 3.16)

project(acm-icpc-team)

add_executable(acm-icpc-team main.cpp)
set_target_properties(acm-icpc-team PROPERTIES
  CXX_STANDARD 14
  CXX_STANDARD_REQUIRED YES)
target_compile_options(acm-icpc-team PRIVATE -Wall -Wextra -pedantic -Werror -g)

