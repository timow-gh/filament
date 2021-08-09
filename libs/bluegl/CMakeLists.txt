cmake_minimum_required(VERSION 3.19)
project(bluegl ASM)

set(TARGET              bluegl)
set(PUBLIC_HDR_DIR      include)

if (WIN32)
    enable_language(ASM_MASM)
    set_property(SOURCE src/BlueGLCoreWindowsImpl.S PROPERTY LANGUAGE ASM_MASM)
endif()

# public headers are always in include/${TARGET}/
file(GLOB_RECURSE PUBLIC_HDRS ${PUBLIC_HDR_DIR}/${TARGET}/*.h)

# list each source file individually
set(SRCS
    src/BlueGL.cpp
)

if (WIN32)
    set(SRCS ${SRCS} src/BlueGLWindows.cpp)
    set(SRCS ${SRCS} src/BlueGLCoreWindowsImpl.S)
elseif (APPLE AND NOT IOS)
    set(SRCS ${SRCS} src/BlueGLDarwin.cpp)
    set(SRCS ${SRCS} src/BlueGLCoreDarwinUniversalImpl.S)
elseif(LINUX)
    set(SRCS ${SRCS} src/BlueGLLinux.cpp)
    set(SRCS ${SRCS} src/BlueGLCoreLinuxUniversalImpl.S)
else()
    message(FATAL_ERROR "Platform not supported. BlueGL supports Windows, Linux, and MacOS X.")
endif()

# we're building a library
add_library(${TARGET} ${PUBLIC_HDRS} ${SRCS})
target_include_directories(${TARGET}
        PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>
        PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/src>)

if (WIN32)
    target_link_libraries(${TARGET} PRIVATE opengl32 gdi32)
endif()

install(TARGETS ${TARGET}
        EXPORT filamentTargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# Build the tests...
add_executable(test_${TARGET}
    tests/OpenGLSupport.cpp
    tests/OpenGLSupport.hpp
    tests/test_bluegl.cpp)

if (LINUX)
    target_link_libraries(test_${TARGET} PUBLIC dl)
endif()

# and we're linking against the libraries below, importing their public headers
target_link_libraries(test_${TARGET} LINK_PUBLIC ${TARGET})
target_link_libraries(test_${TARGET} LINK_PUBLIC gtest)
