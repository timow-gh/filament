cmake_minimum_required(VERSION 3.19)
project(filament-benchmarks)

# ==================================================================================================
# Benchmarks
# ==================================================================================================

set(BENCHMARK_SRCS
        benchmark_filament.cpp)
add_executable(benchmark_filament ${BENCHMARK_SRCS})
target_include_directories(benchmark_filament PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/../src>)
target_link_libraries(benchmark_filament PRIVATE benchmark_main utils math filament)

