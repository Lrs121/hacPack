cmake_minimum_required(VERSION 3.24)
project(hacPack C CXX ASM)

set(CMAKE_CXX_STANDARD 14)
set(ENABLE_TESTING false)
include_directories(src)

set(MBEDTLS_DIR mbedtls/)

# Borealis source with dependencies
add_subdirectory(${MBEDTLS_DIR})

include_directories(src/)
include_directories(mbedtls/configs)
include_directories(mbedtls/doxygen)
include_directories(mbedtls/doxygen/input)
include_directories(mbedtls/include)
include_directories(mbedtls/include/mbedtls)
include_directories(mbedtls/yotta/data)

file(GLOB_RECURSE SOURCES_ASM ${PROJECT_SOURCE_DIR}/src/*.s)
file(GLOB_RECURSE SOURCES_C ${PROJECT_SOURCE_DIR}/src/*.c
        ${PROJECT_SOURCE_DIR}/src/*/*.c
        ${PROJECT_SOURCE_DIR}/src/*/*/*.c)
file(GLOB_RECURSE SOURCES_CXX ${PROJECT_SOURCE_DIR}/src/*.cpp
        ${PROJECT_SOURCE_DIR}/src/*/*.cpp
        ${PROJECT_SOURCE_DIR}/src/*/*/*.cpp)

add_executable(hacPack ${SOURCES_ASM} ${SOURCES_C} ${SOURCES_CXX})
#add_library(hacPack SHARED ${SOURCES_ASM} ${SOURCES_C} ${SOURCES_CXX})

target_link_libraries(hacPack
        mbedcrypto
        )