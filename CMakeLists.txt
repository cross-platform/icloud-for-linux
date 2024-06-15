cmake_minimum_required(VERSION 3.16)

project(icloud-for-linux)

set(CMAKE_CXX_STANDARD 17)

include_directories(subprojects/choc)

add_executable(
    ${PROJECT_NAME}
    src/main.cpp
)
