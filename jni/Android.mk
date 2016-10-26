# -------------------
# Android_4.3.0_so.mk
# [from 'jni/' directory]
# ndk-build clean
# ndk-build
# 20150623: used to create a 'libspatialite.so' with spatialite-4.3.0_so.mk
# -------------------
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARDS)
LOCAL_MODULE := spatial

ICONV_PATH := libiconv-1.13.1
SQLITE_PATH := sqlite-amalgamation-3090200
PROJ4_PATH := proj.4-4.9.2
GEOS_PATH := geos-3.5.0
LZMA_PATH := xz-5.2.2
XML2_PATH := libxml2-2.9.1
SPATIALITE_PATH := libspatialite

include $(LOCAL_PATH)/sqlite-amalgamation-3090200.mk
include $(LOCAL_PATH)/libiconv-1.13.1.mk
include $(LOCAL_PATH)/proj.4-4.9.2.mk
include $(LOCAL_PATH)/geos-3.5.0-CAPI-1.9.0_r4084.mk
include $(LOCAL_PATH)/xz-5.2.2.mk
include $(LOCAL_PATH)/libxml2-2.9.1.mk
include $(LOCAL_PATH)/spatialite-4.4.0-topo-1.so.mk
$(call import-module,android/cpufeatures)
