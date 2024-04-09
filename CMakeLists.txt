cmake_minimum_required(VERSION 3.20.0)
project(KernelLoopInfo)

# find_package(LLVM REQUIRED CONFIG)
find_package(Polly REQUIRED CONFIG)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fuse-ld=lld")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fuse-ld=lld -fno-rtti")


# message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
# message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "Using PollyConfig.cmake in: ${Polly_CMAKE_DIR}")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

include_directories(${Polly_INCLUDE_DIRS})
add_definitions(${Polly_DEFINITIONS})

enable_language(CXX)

add_executable(KernelLoopInfo main.cpp)

# llvm_map_components_to_libnames(llvm_libs support core irreader analysis passes)

target_link_libraries(KernelLoopInfo Polly)
# target_link_libraries(KernelLoopInfo ${Polly_LIBRARIES})
# target_link_libraries(KernelLoopInfo ${llvm_libs})