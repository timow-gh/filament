cmake_minimum_required(VERSION 3.19)
project(stb)

set(TARGET stb)
set(OUR_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)
set(PUBLIC_HDR_DIR ${OUR_DIR})

set(SRCS ../stb_image.cpp)

add_library(${TARGET} STATIC ${PUBLIC_HDRS} ${SRCS})

target_include_directories(${TARGET} INTERFACE $<BUILD_INTERFACE:${PUBLIC_HDR_DIR}>)

file(GLOB_RECURSE PUBLIC_HDRS ${PUBLIC_HDR_DIR}/*.h)