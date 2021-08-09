cmake_minimum_required(VERSION 3.19)
project(bluevk)

set(TARGET              bluevk)
set(PUBLIC_HDR_DIR      include)

file(GLOB_RECURSE PUBLIC_HDRS ${PUBLIC_HDR_DIR}/${TARGET}/*.h)

set(SRCS src/BlueVK.cpp)

# OS specific sources
if (WIN32)
    set(SRCS ${SRCS} src/BlueVKWindows.cpp)
elseif (APPLE)
    set(SRCS ${SRCS} src/BlueVKDarwin.cpp)
elseif (LINUX OR ANDROID)
    set(SRCS ${SRCS} src/BlueVKLinuxAndroid.cpp)
else()
    message(FATAL_ERROR "Platform not supported. BlueVK supports Linux, Android, MacOS X, and Windows.")
endif()

add_library(${TARGET} ${PUBLIC_HDRS} ${SRCS})
target_include_directories(${TARGET} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>)
target_link_libraries(${TARGET} utils math)

# test_bluevk is not supported on mobile or Windows
if (NOT ANDROID AND NOT IOS AND NOT WIN32)
    add_executable(test_bluevk tests/test_bluevk_sdl.cpp)
    target_link_libraries(test_bluevk PRIVATE dl bluevk sdl2)
endif()

install(TARGETS ${TARGET}
        EXPORT filamentTargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})