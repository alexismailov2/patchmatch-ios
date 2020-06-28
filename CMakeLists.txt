cmake_minimum_required(VERSION 3.2)
project(PatchMatch C CXX)

set(CMAKE_C_FLAGS "-x objective-c")
set(CMAKE_CPP_FLAGS "-x objective-c")

set(CMAKE_CXX_STANDARD 14)

set(IOS_DEPENDENCIES ${CMAKE_CURRENT_SOURCE_DIR}/../ios)

include_directories(
  ${IOS_DEPENDENCIES}/include
)

set(PUBLIC_HEADERS
  ${CMAKE_CURRENT_SOURCE_DIR}/src/PatchMatch.h
)

set(PatchMatch_SOURCES
  ${PUBLIC_HEADERS}
  ${CMAKE_CURRENT_SOURCE_DIR}/src/PatchMatch.mm
)

add_library(${PROJECT_NAME}
    SHARED
    ${PatchMatch_SOURCES}
    ${PUBLIC_HEADERS}
)

target_link_libraries(PatchMatch
    PRIVATE
#    "-framework AVFoundation"
#    "-framework CoreMedia"
#    "-framework CoreFoundation"
    "-framework Security"
    ${IOS_DEPENDENCIES}/lib/libpatchmatch.a
)

set_target_properties(PatchMatch PROPERTIES
    FRAMEWORK TRUE
    MACOSX_FRAMEWORK_BUNDLE_VERSION 1.0.0
    MACOSX_FRAMEWORK_IDENTIFIER com.alexismailov.patchmatch
    MACOSX_FRAMEWORK_SHORT_VERSION_STRING 1.0
    PUBLIC_HEADER "${CMAKE_CURRENT_SOURCE_DIR}/src/PatchMatch.h"
)

install(TARGETS PatchMatch DESTINATION ${IOS_DEPENDENCIES})