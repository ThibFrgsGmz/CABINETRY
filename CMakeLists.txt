######################################################################
#
# CMake build recipe for CABINETRY.
#
######################################################################
cmake_minimum_required(VERSION 3.25)

if (BUILD_VERBOSE)
    set(CMAKE_VERBOSE_MAKEFILE ON CACHE BOOL "ON" FORCE) # Debug helper
endif()

message(STATUS "INFO: Running CMake ${CMAKE_VERSION}\n\n")

if(NOT OS OR OS STREQUAL "")
    message(FATAL_ERROR "\n\nMissing build option 'OS', please select one to continue.")
endif()

# Set default version
if(NOT BUILD_VERSION)
    set(BUILD_VERSION 0.0.0.0)
endif()

project(CABINETRY VERSION ${BUILD_VERSION} LANGUAGES C CXX ASM)

set(PROJECT_OUTPUT_NAME cabinetry)

message(STATUS "")
message(STATUS "Building '${CMAKE_PROJECT_NAME}' version ${PROJECT_VERSION} using build type '${CMAKE_BUILD_TYPE}'.")
message(STATUS "Source directory is '${CMAKE_SOURCE_DIR}'.")
message(STATUS "Build  directory is '${CMAKE_BINARY_DIR}'.")
if(BUILD_SHARED_LIBS)
    message(STATUS "Librarian mode is 'SHARED'.")
else()
    message(STATUS "Librarian mode is 'STATIC'.")
endif()
message(STATUS "")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/toolchain/")

include(target)

include_directories("${PROJECT_SOURCE_DIR}/include/")

string(TOLOWER "${DRV_API}" DRV_API_LOWER)

if(DRV_API STREQUAL "Drv-1")
    find_package(Drv1 REQUIRED)

    if (NOT Drv1_FOUND)
        message(SEND_ERROR "\nDrv1 API is not found in the specified path.")
        message(SEND_ERROR "Make sure you have set the `DRV_1_LIB_PATH` cache variable to ${DRV_1_LIB_PATH}.\n")
    endif()
endif()

add_library(${PROJECT_OUTPUT_NAME} "")
add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/src/drivers/${DRV_API_LOWER}")
add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/src/shared")

if(BUILD_SHARED_LIBS AND DRV_API STREQUAL "Drv-1")
    target_link_libraries(${PROJECT_OUTPUT_NAME} PRIVATE "$<LINK_GROUP:RESCAN,${DRV_1_LIBRARIES}>")
endif()


