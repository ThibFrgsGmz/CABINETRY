# FindDrv1
# Locate the Driver 1.
set(Drv1_FOUND TRUE)

set(architecture_type "x86")

if("${CMAKE_GENERATOR}" MATCHES "(Win64|IA64)")
    set(architecture_type "x64")
elseif("${CMAKE_GENERATOR_PLATFORM}" MATCHES "x64")
    set(architecture_type "x64")
elseif("${CMAKE_GENERATOR_PLATFORM}" MATCHES "ARM64")
    set(architecture_type "ARM64")
elseif("${CMAKE_GENERATOR}" MATCHES "ARM")
    set(architecture_type "ARM")
elseif("${CMAKE_GENERATOR_PLATFORM}" MATCHES "ARM")
    set(architecture_type "ARM")
elseif("${CMAKE_SIZEOF_VOID_P}" STREQUAL "8")
    set(architecture_type "x64")
elseif("$ENV{LIB}" MATCHES "(amd64|ia64)")
    set(architecture_type "x64")
endif()

message("\nDriver 1 architecture: ${architecture_type}\n")

string(REPLACE "x" "" architecture_type_without_x_prefix ${architecture_type})

set(DRV_1_LIBRARY_NAMES
    drv_1
    drv_1_1
)
if(CMAKE_HOST_SYSTEM MATCHES Linux)
    list(APPEND DRV_1_LIBRARY_NAMES
        drv_1_2
        drv_1_3
    )
endif()

foreach(DRV_1_LIBRARY_NAME ${DRV_1_LIBRARY_NAMES})

    set(DRV_1_LIBRARY DRV_1_LIBRARY_NAME -NOTFOUND)

    find_library(DRV_1_LIBRARY ${DRV_1_LIBRARY_NAME}
                PATHS
                    ${DRV_1_LIB_PATH}
                PATH_SUFFIXES
                    "lib/${architecture_type}-32" "lib/${architecture_type}-64" "lib/x86-${architecture_type_without_x_prefix}" 
                CMAKE_FIND_ROOT_PATH_BOTH
    )
    
    if(DRV_1_LIBRARY)
        message(STATUS "Found ${DRV_1_LIBRARY_NAME} library at ${DRV_1_LIBRARY}.")
        list(APPEND DRV_1_LIBRARIES ${DRV_1_LIBRARY})
    else()
        message(WARNING "/!\\ Library ${DRV_1_LIBRARY_NAME} not found.")
        set(Drv1_FOUND FALSE)
    endif()

endforeach()

# Find the Drv1 API header files directory
find_path(DRV_1_INCLUDE_DIR "drv-1-api.h"
    PATHS
        ${DRV_1_LIB_PATH}
    PATH_SUFFIXES
        "inc/drv-1" "inc"
)

include_directories(${DRV_1_INCLUDE_DIR})

message("\nDriver 1 include directory: ${DRV_1_INCLUDE_DIR}\n")
