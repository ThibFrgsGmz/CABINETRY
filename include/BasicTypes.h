#ifndef BASIC_TYPES_H
#define BASIC_TYPES_H

#include <stdint.h>
#include "Config.h"

#define COMPILE_TIME_ASSERT(condition, name)       \
    do                                             \
    {                                              \
        enum                                       \
        {                                          \
            assert_failed_##name = 1 / (condition) \
        };                                         \
    } while (0)

typedef int8_t  I8;   //!< 8-bit signed integer
typedef uint8_t U8;   //!< 8-bit unsigned integer
typedef U8      BYTE; //!< byte type
#ifndef __cplusplus
#ifndef bool
typedef U8 bool;
#define false 0
#define true 1
#endif
#endif

#ifdef FW_HAS_16_BIT
typedef int16_t  I16; //!< 16-bit signed integer
typedef uint16_t U16; //!< 16-bit unsigned integer
#endif

#ifdef FW_HAS_32_BIT
typedef uint32_t U32; //!< 32-bit signed integer
typedef int32_t  I32; //!< 32-bit unsigned integer
#endif

#ifdef FW_HAS_64_BIT
typedef int64_t  I64; //!< 64-bit signed integer
typedef uint64_t U64; //!< 64-bit unsigned integer
#endif

typedef float F32; //!< 32-bit floating point
#ifdef FW_HAS_F64
typedef double F64; //!< 64-bit floating point
#endif

typedef char CHAR;

#define FW_NUM_ARRAY_ELEMENTS(a) (sizeof(a) / sizeof((a)[0])) //!< number of elements in an array

#define FW_MAX(a, b) (((a) > (b)) ? (a) : (b)) //!< MAX macro
#define FW_MIN(a, b) (((a) < (b)) ? (a) : (b)) //!< MIN macro

#endif