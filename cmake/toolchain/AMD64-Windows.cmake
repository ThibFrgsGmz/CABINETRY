# System setup for Windows
# See https://cmake.org/cmake/help/book/mastering-cmake/chapter/Cross%20Compiling%20With%20CMake.html
include_guard()
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR AMD64)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY" CACHE STRING "Try Static Lib Type" FORCE)

set(TOOLCHAIN_PATH "P:\\Program Files\\LLVM\\bin")
message(STATUS "Toolchain Dir:  ${TOOLCHAIN_PATH}")

set(TOOLCHAIN_SUFFIX ".exe")

set(CMAKE_C_COMPILER   "${TOOLCHAIN_PATH}\\clang${TOOLCHAIN_SUFFIX}"            CACHE PATH "clang"      FORCE)
set(CMAKE_CXX_COMPILER "${TOOLCHAIN_PATH}\\clang++${TOOLCHAIN_SUFFIX}"          CACHE PATH "clang++"    FORCE)
set(CMAKE_ASM_COMPILER "${TOOLCHAIN_PATH}\\clang${TOOLCHAIN_SUFFIX}"            CACHE PATH "assembler"  FORCE)
set(CMAKE_AR           "${TOOLCHAIN_PATH}\\llvm-ar${TOOLCHAIN_SUFFIX}"          CACHE PATH "archiver"   FORCE)
set(CMAKE_LINKER       "${TOOLCHAIN_PATH}\\lld-link${TOOLCHAIN_SUFFIX}"         CACHE PATH "linker"     FORCE)
set(CMAKE_NM           "${TOOLCHAIN_PATH}\\llvm-nm${TOOLCHAIN_SUFFIX}"          CACHE PATH "nm"         FORCE)
set(CMAKE_OBJCOPY      "${TOOLCHAIN_PATH}\\llvm-objcopy${TOOLCHAIN_SUFFIX}"     CACHE PATH "objcopy"    FORCE)
set(CMAKE_OBJDUMP      "${TOOLCHAIN_PATH}\\llvm-objdump${TOOLCHAIN_SUFFIX}"     CACHE PATH "objdump"    FORCE)
set(CMAKE_STRIP        "${TOOLCHAIN_PATH}\\llvm-strip${TOOLCHAIN_SUFFIX}"       CACHE PATH "strip"      FORCE)
set(CMAKE_SIZE         "${TOOLCHAIN_PATH}\\llvm-size${TOOLCHAIN_SUFFIX}"        CACHE PATH "size"       FORCE)
set(CMAKE_RANLIB       "${TOOLCHAIN_PATH}\\llvm-ranlib${TOOLCHAIN_SUFFIX}"      CACHE PATH "ranlib"     FORCE)

set(FLAGS_DEF "")
set(FLAGS_COM "-Wall -D_CRT_SECURE_NO_WARNINGS")
set(FLAGS_CPU "")
set(FLAGS_STD "")

set(CMAKE_C_FLAGS                   "${FLAGS_DEF} ${FLAGS_COM} ${FLAGS_CPU} ${FLAGS_STD}")
set(CMAKE_C_FLAGS_DEBUG             "-DDEBUG -g -Xclang -gcodeview -O0")
set(CMAKE_C_FLAGS_MINSIZEREL        "-Os -DNDEBUG")
set(CMAKE_C_FLAGS_RELEASE           "-O3 -DNDEBUG")
set(CMAKE_C_FLAGS_RELWITHDEBINFO    "-O2 -g -DNDEBUG -Xclang -gcodeview")

# Search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# Search for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

foreach(lang IN ITEMS C CXX)
    # Specify the C and C++ standard required for ALL targets
    set(CMAKE_${lang}_STANDARD 11 CACHE INTERNAL "The ${lang} standard whose features are requested to build this target.")
    # Force the specified language standard: if the compiler does not support the specified standard, it will generate an error.
    # Without this CMake will be resilient and will fall back to the last standard the compiler supports instead.
    set(CMAKE_${lang}_STANDARD_REQUIRED ON)
    # Disable all C and C++ extensions on ALL targets.
    # This forces the use of -std=c17 and -std=c++17 instead of -std=gnu17 and -std=gnu++17
    set(CMAKE_${lang}_EXTENSIONS OFF CACHE INTERNAL "${lang} compiler extensions OFF")
endforeach()
