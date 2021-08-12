cmake_minimum_required(VERSION 3.19)
project(smol-v)

set(TARGET smol-v)

set(PUBLIC_HDR_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../source)
set(SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../source)

set(SRCS
    ${SRC_DIR}/smolv.cpp
)

add_library(${TARGET} ${SRCS})

target_compile_options(${TARGET} PRIVATE
        $<$<PLATFORM_ID:Linux>:-fPIC>
)

if (NOT MSVC)
    target_compile_options(${TARGET} PRIVATE -Wno-tautological-unsigned-enum-zero-compare)
endif()

target_include_directories(${TARGET} PUBLIC )
target_include_directories(${TARGET} PUBLIC $<BUILD_INTERFACE:${PUBLIC_HDR_DIR}>)

install(TARGETS ${TARGET}
        EXPORT filamentTargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})