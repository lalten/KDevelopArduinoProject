set(ARDUINO_BOARD "AVR_LEONARDO")
set(ARDUINO_VARIANTS "leonardo")
set(ARDUINO_MCU "atmega32u4")
set(ARDUINO_FCPU "16000000L")
set(ARDUINO_UPLOAD_PROTOCOL "avr109")
set(ARDUINO_UPLOAD_SPEED "57600")
set(ARDUINO_PORT "/dev/ttyACM0")
# # HACK
# add_definitions(-DUSB_VID=0x2341)
# add_definitions(-DUSB_PID=0x8036)

include(${CMAKE_SOURCE_DIR}/platforms/libarduino.cmake)
