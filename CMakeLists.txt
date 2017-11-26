project(arduinoproject)
cmake_minimum_required(VERSION 3.3.1)

include(${CMAKE_SOURCE_DIR}/platforms/arduino_leonardo.cmake)

set(MYPROJECT_SOURCE_FILES
	${CMAKE_SOURCE_DIR}/src/arduino_main.cpp
	${ARDUINO_SOURCE_FILES}
)

add_executable(arduinoproject ${MYPROJECT_SOURCE_FILES})
