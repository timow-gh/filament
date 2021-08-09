cmake_minimum_required(VERSION 3.19)
project(math)

set(TARGET math)
set(PUBLIC_HDR_DIR include)

if (MSVC)
    set(OPTIMIZATION_FLAGS /fp:fast)
else()
    set(OPTIMIZATION_FLAGS -ffast-math -ffp-contract=fast)
endif()

# ==================================================================================================
# Sources and headers
# ==================================================================================================
set(PUBLIC_HDRS
        include/math/TMatHelpers.h
        include/math/TQuatHelpers.h
        include/math/TVecHelpers.h
        include/math/compiler.h
        include/math/fast.h
        include/math/half.h
        include/math/mathfwd.h
        include/math/mat2.h
        include/math/mat3.h
        include/math/mat4.h
        include/math/norm.h
        include/math/quat.h
        include/math/scalar.h
        include/math/vec2.h
        include/math/vec3.h
        include/math/vec4.h
)

set(SRCS src/dummy.cpp)

# ==================================================================================================
# Include and target definitions
# ==================================================================================================
add_library(${TARGET} STATIC ${PUBLIC_HDRS} ${SRCS})
target_compile_options(${TARGET} PRIVATE ${OPTIMIZATION_FLAGS})
target_include_directories(${TARGET} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>)

# ==================================================================================================
# Installation
# ==================================================================================================
install(DIRECTORY ${PUBLIC_HDR_DIR}/math DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")
install(TARGETS ${TARGET}
        EXPORT filamentTargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${DIST_DIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# ==================================================================================================
# Tests
# ==================================================================================================
add_executable(test_${TARGET}
        tests/test_fast.cpp
        tests/test_half.cpp
        tests/test_mat.cpp
        tests/test_vec.cpp
        tests/test_quat.cpp
)
target_link_libraries(test_${TARGET} PRIVATE math gtest)

# ==================================================================================================
# Benchmarks
# ==================================================================================================

set(BENCHMARK_SRCS
        benchmarks/benchmark_fast.cpp include/math/mathfwd.h)

add_executable(benchmark_${TARGET} ${BENCHMARK_SRCS})

target_compile_options(benchmark_${TARGET} PRIVATE ${OPTIMIZATION_FLAGS})

target_link_libraries(benchmark_${TARGET} PRIVATE benchmark_main utils math)
