#!/bin/bash

BASE=$(cd "$(dirname "$0")" && pwd)
JNIDIR="${BASE}/jni"
CONFIGSDIR="${BASE}/generated_configs"
PREFIX="${BASE}/darwin/amd64"
INCLUDEDIR="${PREFIX}/include"
LIBDIR="${PREFIX}/lib"

ZLIB_PATH="${JNIDIR}/zlib-1.2.8"
ICONV_PATH="${JNIDIR}/libiconv-1.14"
SQLITE_PATH="${JNIDIR}/sqlite-autoconf-3090200"
PROJ4_PATH="${JNIDIR}/proj.4-4.9.2"
GEOS_PATH="${JNIDIR}/geos-3.5.0"
LZMA_PATH="${JNIDIR}/xz-5.2.2"
XML2_PATH="${JNIDIR}/libxml2-2.9.1"
SPATIALITE_PATH="${JNIDIR}/libspatialite"

