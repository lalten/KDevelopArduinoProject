#
# StanislavAS
# stanislav.echo@gmail.com
#

enable_language(C ASM)

set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_ASM_COMPILER avr-as)
set(CMAKE_C_COMPILER avr-gcc)
set(CMAKE_CXX_COMPILER avr-g++)
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

set(CMAKE_ASM_FLAGS "")
set(CMAKE_C_FLAGS "-g -Os -std=gnu11 -Wall -ffunction-sections -fdata-sections -MMD -mmcu=${ARDUINO_MCU} -DF_CPU=${ARDUINO_FCPU} -DARDUINO_${ARDUINO_BOARD}")
set(CMAKE_CXX_FLAGS "-g -Os -std=gnu++11 -Wall -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -MMD -mmcu=${ARDUINO_MCU} -DF_CPU=${ARDUINO_FCPU} -DARDUINO_${ARDUINO_BOARD}")


set(ARDUINO_CORE_DIR "arduino/core")
include_directories(${ARDUINO_CORE_DIR})
file(GLOB ARDUINO_CORE_FILES
  "${ARDUINO_CORE_DIR}/*.h"
  "${ARDUINO_CORE_DIR}/*.S"
  "${ARDUINO_CORE_DIR}/*.c"
  "${ARDUINO_CORE_DIR}/*.cpp"
)

set(ARDUINO_PINS_DIR "arduino/variants/${ARDUINO_VARIANTS}")
include_directories(${ARDUINO_PINS_DIR})
file(GLOB ARDUINO_PINS_FILES
  "${ARDUINO_PINS_DIR}/*"
)

set(AVR_INCLUDE_DIR "/opt/arduino/arduino-1.8.5/hardware/tools/avr/avr/include")
include_directories(${AVR_INCLUDE_DIR})
file(GLOB AVR_INCLUDE_FILES
  "${AVR_INCLUDE_DIR}/avr/*.h"
)

set(ARDUINO_SOURCE_FILES
	${ARDUINO_PINS_FILES}
	${ARDUINO_CORE_FILES}
	${AVR_INCLUDE_FILES}
)

set(PORT $ENV{ARDUINO_PORT})
if (NOT PORT)
	set(PORT ${ARDUINO_PORT})
endif()

find_program(AVROBJCOPY "avr-objcopy")
find_program(AVRDUDE "avrdude")

if(AVROBJCOPY AND AVRDUDE)
	# Make firmware
	add_custom_target(hex)
	add_dependencies(hex arduinoproject)
	add_custom_command(TARGET hex POST_BUILD
		COMMAND ${AVROBJCOPY} -O ihex -R .eeprom ${CMAKE_CURRENT_BINARY_DIR}/arduinoproject ${ARDUINO_MCU}_${ARDUINO_VARIANTS}.hex
	)
	
	# Upload hex to arduino
	add_custom_target(upload)
	add_dependencies(upload hex)
	add_custom_command(TARGET upload POST_BUILD
		COMMAND ${AVRDUDE} -v -v -v -v -P${PORT} -b${ARDUINO_UPLOAD_SPEED} -c${ARDUINO_UPLOAD_PROTOCOL} -p${ARDUINO_MCU} -V -Uflash:w:${ARDUINO_MCU}_${ARDUINO_VARIANTS}.hex:i
	)
endif()
