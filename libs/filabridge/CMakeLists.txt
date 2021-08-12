cmake_minimum_required(VERSION 3.19)
project(filabridge)

set(TARGET         filabridge)
set(PUBLIC_HDR_DIR include)

# ==================================================================================================
# Sources and headers
# ==================================================================================================
file(GLOB_RECURSE PUBLIC_HDRS ${PUBLIC_HDR_DIR}/**/*.h)

set(SRCS
        src/SamplerBindingMap.cpp
        src/SamplerInterfaceBlock.cpp
        src/UniformInterfaceBlock.cpp
        src/SibGenerator.cpp
)

# ==================================================================================================
# Include and target definitions
# ==================================================================================================
add_library(${TARGET} ${PUBLIC_HDRS} ${SRCS})
target_include_directories(${TARGET} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>)
target_link_libraries(${TARGET} utils math backend)

# ==================================================================================================
# Installation
# ==================================================================================================
install(DIRECTORY ${PUBLIC_HDR_DIR}/filament DESTINATION include)
install(TARGETS ${TARGET}
        EXPORT filamentTargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
