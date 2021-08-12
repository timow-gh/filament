cmake_minimum_required(VERSION 3.19)
project(filameshio)

set(TARGET filameshio)
set(PUBLIC_HDR_DIR include)

# ==================================================================================================
# Sources and headers
# ==================================================================================================
set(PUBLIC_HDRS
    ${PUBLIC_HDR_DIR}/${TARGET}/filamesh.h
    ${PUBLIC_HDR_DIR}/${TARGET}/MeshReader.h
)

set(DIST_HDRS ${PUBLIC_HDR_DIR}/${TARGET}/MeshReader.h)
set(SRCS src/MeshReader.cpp)

# ==================================================================================================
# Includes and target definition
# ==================================================================================================
add_library(${TARGET} ${PUBLIC_HDRS} ${SRCS})
target_include_directories(${TARGET} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>)
target_link_libraries(${TARGET}
    PRIVATE meshoptimizer
    PUBLIC filament # Public only because the filamesh API needs Box.h
)

# ==================================================================================================
# Installation
# ==================================================================================================
set(INSTALL_TYPE ARCHIVE)
install(FILES ${DIST_HDRS} DESTINATION include/${TARGET})
install(TARGETS ${TARGET}
        EXPORT filamentTargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# ==================================================================================================
# Tests
# ==================================================================================================
if (NOT IOS AND NOT WEBGL AND NOT ANDROID)
    add_executable(test_${TARGET} tests/test_filamesh.cpp )
    target_link_libraries(test_${TARGET} PRIVATE filameshio gtest)
endif()
