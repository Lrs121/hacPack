cmake_minimum_required(VERSION 3.24)
project(hacPack)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)
include_directories(mbedtls/configs)
include_directories(mbedtls/doxygen)
include_directories(mbedtls/doxygen/input)
include_directories(mbedtls/include)
include_directories(mbedtls/include/mbedtls)
include_directories(mbedtls/yotta/data)

