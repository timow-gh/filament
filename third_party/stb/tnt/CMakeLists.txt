cmake_minimum_required(VERSION 3.19)
project(stb)

set(TARGET stb)

set(PUBLIC_HDR_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)

set(PUBLIC_HDRS ../stb_image.h)

add_library(${TARGET} ${PUBLIC_HDRS} ${SRCS})
target_include_directories(${TARGET} INTERFACE $<BUILD_INTERFACE:${PUBLIC_HDR_DIR}>)

install(TARGETS stb ARCHIVE DESTINATION lib/${DIST_DIR})
