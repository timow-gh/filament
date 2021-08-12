cmake_minimum_required(VERSION 3.19)
project(trie)

set(TARGET trie)
set(OUR_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)

# ==================================================================================================
# Sources and headers
# ==================================================================================================
set(PUBLIC_HDRS
        ${OUR_DIR}/tsl/htrie_hash.h
        ${OUR_DIR}/tsl/htrie_map.h
        ${OUR_DIR}/tsl/htrie_set.h
)

# ==================================================================================================
# Include and target definitions
# ==================================================================================================
add_library(${TARGET} INTERFACE)
target_include_directories(${TARGET} INTERFACE $<BUILD_INTERFACE:${OUR_DIR}>)

# ==================================================================================================
# Installation
# ==================================================================================================
install(FILES ${PUBLIC_HDRS} DESTINATION include/${TARGET})
install(TARGETS ${TARGET}
        EXPORT filamentTargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})