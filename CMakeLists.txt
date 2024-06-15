cmake_minimum_required(VERSION 3.16)

project(icloud-for-linux)

set(CMAKE_CXX_STANDARD 17)

include_directories(subprojects/choc)

add_executable(
    ${PROJECT_NAME}
    src/main.cpp
)

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    find_package(PkgConfig REQUIRED)
    pkg_check_modules (gtk3 REQUIRED gtk+-3.0 IMPORTED_TARGET)
    pkg_check_modules (webkit2 REQUIRED webkit2gtk-4.0 IMPORTED_TARGET)
    target_link_libraries (${PROJECT_NAME} PUBLIC pthread PkgConfig::gtk3 PkgConfig::webkit2)
else()
    target_link_libraries(${PROJECT_NAME} "-framework WebKit")
endif()

install(TARGETS ${PROJECT_NAME} DESTINATION bin)
