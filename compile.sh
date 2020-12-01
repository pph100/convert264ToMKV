#!/bin/bash

USER_ROOT="${HOME}"
TC_TYPE=DSM
TC_TARGET=x86_64-pc-linux-gnu
TC_PREFIX=${TC_TARGET}-

TC_ROOT="${USER_ROOT}/spksrc/toolchains/"
TC_ARCH=apollolake
SEL_TEMP="syno-${TC_ARCH}-*/work/*/bin"
VERS="$(ls -1 ${TC_ROOT}${SEL_TEMP}/*gcc | sed 's,/,:,g' | LC_ALL=C sort -rit '-' | head -1 | cut -d'-' -f3 | cut -d':' -f1)"
SEL="${TC_ROOT}syno-apollolake-${VERS}/work/${TC_TARGET}/bin"
SEL2="${TC_ROOT}syno-apollolake-${VERS}/work/*/*/sys-root"
## TC_PATH=/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/
TC_PATH="${SEL}/"

LD="$(ls -1 ${SEL}/*-ld)"
LDSHARED="$(ls -1 ${SEL}/*-gcc) -shared"
CPP="$(ls -1 ${SEL}/*-cpp)"
NM="$(ls -1 ${SEL}/*-nm)"
CC="$(ls -1 ${SEL}/*-gcc)"
AS="$(ls -1 ${SEL}/*-as)"
RANLIB="$(ls -1 ${SEL}/*-ranlib)"
CXX="$(ls -1 ${SEL}/*-g++)"
AR="$(ls -1 ${SEL}/*-ar)"
STRIP="$(ls -1 ${SEL}/*-strip)"
OBJDUMP="$(ls -1 ${SEL}/*-objdump)"
READELF="$(ls -1 ${SEL}/*-readelf)"
CFLAGS="-I$(ls -1d ${SEL2}/usr/include) "
CPPFLAGS="-I$(ls -1d ${SEL2}/usr/include) "
CXXFLAGS="-I$(ls -1d ${SEL2}/usr/include) "
LDFLAGS="-L$(ls -1d ${SEL2}/lib) "

### LD="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-ld"
### LDSHARED="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-gcc -shared"
### CPP="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-cpp"
### NM="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-nm"
### CC="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-gcc"
### AS="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-as"
### RANLIB="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-ranlib"
### CXX="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-g++"
### AR="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-ar"
### STRIP="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-strip"
### OBJDUMP="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-objdump"
### READELF="/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/x86_64-pc-linux-gnu-readelf"
### CFLAGS="-I/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/usr/include "
### CPPFLAGS="-I/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/usr/include "
### CXXFLAGS="-I/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/usr/include "
### LDFLAGS="-L/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/lib "
### TC_PATH=/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/bin/
### CFLAGS="-I/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/usr/include "
### CPPFLAGS="-I/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/usr/include "
### CXXFLAGS="-I/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/usr/include "
### LDFLAGS="-L/home/uli/spksrc/toolchains/syno-apollolake-6.1/work/x86_64-pc-linux-gnu/x86_64-pc-linux-gnu/sys-root/lib "

TC_CONFIGURE_ARGS="--host=x86_64-pc-linux-gnu --build=i686-pc-linux"
TC_LIBRARY=x86_64-pc-linux-gnu/sys-root/lib
TC_INCLUDE=x86_64-pc-linux-gnu/sys-root/usr/include
TC_EXTRA_CFLAGS=
### TC_VERS=6.1
TC_VERS=${VERS}
TC_BUILD=15047
TC_OS_MIN_VER=${TC_VERS}-${TC_BUILD}


echo "$CC $CFLAGS -o convert264ToMKV convert_264_to_mkv.c"
$CC $CFLAGS -o convert264ToMKV convert_264_to_mkv.c
