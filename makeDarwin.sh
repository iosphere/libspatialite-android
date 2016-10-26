#!/bin/bash

set -e
BASE=$(cd "$(dirname "$0")" && pwd)
source "${BASE}/pathSetup.sh"

# SQLITE
cd "${SQLITE_PATH}"
env CFLAGS='-DSQLITE_ENABLE_LOAD_EXTENSION' ./configure --prefix="${PREFIX}" --disable-static --enable-json1
make
make install
make distclean

# ZLIB
cd "${ZLIB_PATH}"
./configure --prefix="${PREFIX}"
make
make install
make distclean

# ICONV
cd "${ICONV_PATH}"
./configure --prefix="${PREFIX}" --disable-static
make
make install
make distclean

# XZ
cd "${LZMA_PATH}"
./configure --prefix="${PREFIX}" --disable-static --with-libiconv-prefix="${PREFIX}"
make
make install
make distclean

# LIBXML2
cd "${XML2_PATH}"
./configure --prefix="${PREFIX}" --disable-static --with-lzma="${PREFIX}" --with-iconv="${PREFIX}"
make
make install
make distclean

# PROJ
cd "${PROJ4_PATH}"
./configure --prefix="${PREFIX}" --disable-static --without-jni
make
make install
make distclean

# GEOS
cd "${GEOS_PATH}"
./configure --prefix="${PREFIX}" --disable-static
make
make install
make distclean

# Spatialite
export CFLAGS="-I${INCLUDEDIR}"
export LDFLAGS="-L${LIBDIR}"
cd "${SPATIALITE_PATH}"
./configure --prefix="${PREFIX}" --enable-module-only --with-geosconfig="${PREFIX}/bin/geos-config" --disable-examples --disable-freexl
make
make install
make distclean
cp "${LIBDIR}/mod_spatialite.7.so" "${LIBDIR}/mod_spatialite.dylib"

# Fixing dynamic library search paths
for fullPath in $(find $LIBDIR -type f -maxdepth 1 -regex ".*[.dylib]\$")
do
    fileName=$(basename $fullPath)
    install_name_tool -id "${fileName}" "${fullPath}"
    if [ "${fileName}" == 'libgeos_c.1.dylib' ]
    then
        install_name_tool -change "${LIBDIR}/libgeos-3.5.0.dylib" "@loader_path/libgeos-3.5.0.dylib" "${fullPath}"
    fi
    if [ "${fileName}" == 'libxml2.2.dylib' ]
    then
        install_name_tool -change "${LIBDIR}/libz.1.dylib" "@loader_path/libz.1.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/liblzma.5.dylib" "@loader_path/liblzma.5.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/libiconv.2.dylib" "@loader_path/libiconv.2.dylib" "${fullPath}"
    fi
    if [ "${fileName}" == 'mod_spatialite.dylib' ]
    then
        install_name_tool -change "${LIBDIR}/libgeos_c.1.dylib" "@loader_path/libgeos_c.1.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/libgeos-3.5.0.dylib" "@loader_path/libgeos-3.5.0.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/libproj.9.dylib" "@loader_path/libproj.9.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/libsqlite3.0.dylib" "@loader_path/libsqlite3.0.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/libxml2.2.dylib" "@loader_path/libxml2.2.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/liblzma.5.dylib" "@loader_path/liblzma.5.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/libcharset.1.dylib" "@loader_path/libcharset.1.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/libiconv.2.dylib" "@loader_path/libiconv.2.dylib" "${fullPath}"
        install_name_tool -change "${LIBDIR}/libz.1.dylib" "@loader_path/libz.1.dylib" "${fullPath}"
    fi
done

