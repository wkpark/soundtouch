LOCAL_PATH := $(call my-dir)

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

#include stlport headers
include external/stlport/libstlport.mk

LOCAL_C_INCLUDES += $(LOCAL_PATH)/include
LOCAL_LDLIBS	+= -llog
# "-marm" switch to use arm instruction set instead of thumb for improved calculation performance.
LOCAL_CFLAGS	+= -Wall -fvisibility=hidden -I include \
		-U_FORTIFY_SOURCE \
		-D ST_NO_EXCEPTION_HANDLING -fdata-sections -ffunction-sections -marm

include $(BUILD_STATIC_LIBRARY)
