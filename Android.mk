LOCAL_PATH := $(call my-dir)

soundtouch_export_includes := $(LOCAL_PATH)/include

include $(CLEAR_VARS)

LOCAL_MODULE	:= libsoundtouch
LOCAL_SRC_FILES := source/SoundTouch/AAFilter.cpp \
		source/SoundTouch/FIFOSampleBuffer.cpp \
		source/SoundTouch/FIRFilter.cpp \
		source/SoundTouch/cpu_detect_x86.cpp \
		source/SoundTouch/RateTransposer.cpp \
		source/SoundTouch/SoundTouch.cpp \
		source/SoundTouch/TDStretch.cpp \
		source/SoundTouch/BPMDetect.cpp \
		source/SoundTouch/PeakFinder.cpp \
		source/SoundTouch/InterpolateLinear.cpp \
		source/SoundTouch/InterpolateCubic.cpp \
		source/SoundTouch/InterpolateShannon.cpp

LOCAL_SDK_VERSION := 9
LOCAL_NDK_STL_VARIANT := stlport_static

LOCAL_C_INCLUDES += $(soundtouch_export_includes)
LOCAL_CFLAGS	+= -Wall -fvisibility=hidden -I include \
		-O3 -funroll-loops \
		-U_FORTIFY_SOURCE \
		-D ST_NO_EXCEPTION_HANDLING -fdata-sections -ffunction-sections \

#LOCAL_CFLAGS += -DSOUNDTOUCH_INTEGER_SAMPLES=1

LOCAL_EXPORT_C_INCLUDES := $(soundtouch_export_includes)
LOCAL_EXPORT_CPPFLAGS := $(soundtouch_export_cxxflags)
LOCAL_EXPORT_LDFLAGS := $(soundtouch_export_ldflags)

# support both ndk-build and AOSP build system
ifeq (,$(TARGET_ARCH_ABI))
    ifeq (arm,$(TARGET_ARCH))
        TARGET_ARCH_ABI := armeabi
    endif
endif

# "-marm" switch to use arm instruction set instead of thumb for improved calculation performance.
ifneq (,$(filter armeabi%,$(TARGET_ARCH_ABI)))
    LOCAL_CFLAGS += -marm
# Use ARM instruction set instead of Thumb for improved calculation performance in ARM CPUs
    LOCAL_ARM_MODE := arm
endif
ifneq (,$(filter x86%,$(TARGET_ARCH_ABI)))
    LOCAL_CFLAGS += -mmmx -DSOUNDTOUCH_ALLOW_MMX=1
    LOCAL_SRC_FILES += source/SoundTouch/mmx_optimized.cpp
endif

include $(BUILD_STATIC_LIBRARY)
