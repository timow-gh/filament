project(meshoptimizer)
cmake_minimum_required(VERSION 3.10)

# option(BUILD_DEMO "Build demo" OFF)

set(SOURCES
    src/meshoptimizer.h
    src/clusterizer.cpp
    src/indexcodec.cpp
    src/indexgenerator.cpp
    src/overdrawanalyzer.cpp
    src/overdrawoptimizer.cpp
    src/simplifier.cpp
    src/stripifier.cpp
    src/vcacheanalyzer.cpp
    src/vcacheoptimizer.cpp
    src/vertexcodec.cpp
    src/vfetchanalyzer.cpp
    src/vfetchoptimizer.cpp
)

add_library(meshoptimizer ${SOURCES})
target_include_directories(meshoptimizer PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>)

if(MSVC)
	target_compile_options(meshoptimizer PRIVATE /W4 /WX)
else()
	target_compile_options(meshoptimizer PRIVATE -Wall -Wextra -Werror)
endif()

if(BUILD_DEMO)
    add_executable(demo demo/main.cpp demo/miniz.cpp demo/objparser.cpp)
    target_link_libraries(demo meshoptimizer)
endif()

install(TARGETS meshoptimizer
        EXPORT filamentTargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
