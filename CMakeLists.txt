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

# Get the latest abbreviated commit hash of the working branch
execute_process(
    COMMAND git log -1 --format=%h
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    OUTPUT_VARIABLE GIT_SHORT_HASH
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )


project(CABINETRY VERSION ${BUILD_VERSION} LANGUAGES C CXX ASM)
set(PROJECT_OUTPUT_NAME cabinetry)

# ---[ Options.
# Note to developers: if you add an option below, make sure you also add it to
# cmake/Summary.cmake so that the summary prints out the option values.
option(BUILD_SHARED_LIBS "Build .dll/.so" OFF)
option(BUILD_TEST "Build C++ test binaries (need gtest and gbenchmark)" OFF)
option(USE_CODE_COVERAGE "Compile C/C++ with code coverage flags" OFF)
option(USE_ASAN "Use Address+Undefined Sanitizers" OFF)
option(USE_TSAN "Use Thread Sanitizer" OFF)

# ---[ CMake scripts + modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/toolchain/")

# ---[ CMake build directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

include(target)
include(Summary)
print_configuration_summary()

include_directories("${PROJECT_SOURCE_DIR}/include/")

set(VERSION_FILE_HPP "cabinetry_version.h")
set(VERSION_FILE_CMAKE "${VERSION_FILE_HPP}.in")
configure_file("${CMAKE_SOURCE_DIR}/cmake/${VERSION_FILE_CMAKE}"
    "${CMAKE_SOURCE_DIR}/include/${VERSION_FILE_HPP}"
    ESCAPE_QUOTES)



# string(TOLOWER "${DRV_API}" DRV_API_LOWER)

# if(DRV_API STREQUAL "Drv-1")
#     find_package(Drv1 REQUIRED)

#     if (NOT Drv1_FOUND)
#         message(SEND_ERROR "\nDrv1 API is not found in the specified path.")
#         message(SEND_ERROR "Make sure you have set the `DRV_1_LIB_PATH` cache variable to ${DRV_1_LIB_PATH}.\n")
#     endif()
# endif()

add_library(${PROJECT_OUTPUT_NAME} "")
# add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/src/drivers/${DRV_API_LOWER}")
add_subdirectory("${CMAKE_CURRENT_LIST_DIR}/src/shared")

# if(BUILD_SHARED_LIBS AND DRV_API STREQUAL "Drv-1")
#     target_link_libraries(${PROJECT_OUTPUT_NAME} PRIVATE "$<LINK_GROUP:RESCAN,${DRV_1_LIBRARIES}>")
# endif()

# Experience shows that explicit package naming can help make it easier to sort
# out potential ABI related issues before they start, while helping you
# track a build to a specific GIT HASH
# set(CPACK_PACKAGE_FILE_NAME
#     "${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}-${GIT_SHORT_HASH}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}"
# )
# include(CPack)

