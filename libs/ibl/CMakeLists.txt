cmake_minimum_required(VERSION 3.19)
project(cmgen)

set(TARGET ibl)
set(PUBLIC_HDR_DIR include)

# ==================================================================================================
# Sources and headers
# ==================================================================================================
set(PUBLIC_HDRS
    ${PUBLIC_HDR_DIR}/ibl/Cubemap.h
    ${PUBLIC_HDR_DIR}/ibl/CubemapIBL.h
    ${PUBLIC_HDR_DIR}/ibl/CubemapSH.h
    ${PUBLIC_HDR_DIR}/ibl/CubemapUtils.h
    ${PUBLIC_HDR_DIR}/ibl/Image.h
    ${PUBLIC_HDR_DIR}/ibl/utilities.h
)

set(PRIVATE_HDRS
    src/CubemapUtilsImpl.h
)

set(SRCS
    src/Cubemap.cpp
    src/CubemapIBL.cpp
    src/CubemapSH.cpp
    src/CubemapUtils.cpp
    src/Image.cpp
)

# ==================================================================================================
# Target definitions
# ==================================================================================================
add_library(${TARGET} ${PUBLIC_HDRS} ${PRIVATE_HDRS} ${SRCS})
target_include_directories(${TARGET} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>)
target_link_libraries(${TARGET} math utils)

add_library(${TARGET}-lite ${PUBLIC_HDRS} ${PRIVATE_HDRS} ${SRCS})
target_compile_definitions(${TARGET}-lite PUBLIC -DFILAMENT_IBL_LITE=1)
target_include_directories(${TARGET}-lite PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>)
target_link_libraries(${TARGET}-lite math utils)

# ==================================================================================================
# Compile options and optimizations
# ==================================================================================================
if (MSVC)
    target_compile_options(${TARGET} PRIVATE /fp:fast)
    target_compile_options(${TARGET}-lite PRIVATE /fp:fast)
else()
    target_compile_options(${TARGET} PRIVATE -ffast-math)
    target_compile_options(${TARGET}-lite PRIVATE -ffast-math)
endif()


# ==================================================================================================
# Installation
# ==================================================================================================
install(DIRECTORY ${PUBLIC_HDR_DIR}/ibl DESTINATION include)
install(TARGETS ${TARGET} ${TARGET}-lite
        EXPORT filamentTargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})