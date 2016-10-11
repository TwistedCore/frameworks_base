# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH:= $(call my-dir)

# libandroidfw is partially built for the host (used by obbtool, aapt, and others)
# These files are common to host and target builds.

commonSources := \
    Asset.cpp \
    AssetDir.cpp \
    AssetManager.cpp \
    misc.cpp \
    ObbFile.cpp \
    ResourceTypes.cpp \
    StreamingZipInflater.cpp \
    TypeWrappers.cpp \
    ZipFileRO.cpp \
    ZipUtils.cpp


# For the host
# =====================================================
include $(CLEAR_VARS)
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk

LOCAL_MODULE:= libaoptfw
LOCAL_MODULE_TAGS := optional
LOCAL_CPPFLAGS := -std=gnu++11 -Wno-missing-field-initializers
LOCAL_CFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS
LOCAL_CFLAGS += -Wall -Werror -Wunused -Wunreachable-code
LOCAL_C_INCLUDES := external/zlib
LOCAL_STATIC_LIBRARIES := libziparchive libbase
ifdef TARGET_2ND_ARCH
LOCAL_MULTILIB := both
LOCAL_SRC_FILES_64 := $(commonSources)
LOCAL_SRC_FILES_32 := $(commonSources)
else
LOCAL_SRC_FILES := $(commonSources)
endif
include $(BUILD_STATIC_LIBRARY)





# Include subdirectory makefiles
# ============================================================

# If we're building with ONE_SHOT_MAKEFILE (mm, mmm), then what the framework
# team really wants is to build the stuff defined by this makefile.
ifeq (,$(ONE_SHOT_MAKEFILE))
include $(call first-makefiles-under,$(LOCAL_PATH))
endif
