////////////////////////////////////////////////////////////////////////////////
///
/// Example Interface class for SoundTouch native compilation
///
/// Author        : Copyright (c) Olli Parviainen
/// Author e-mail : oparviai 'at' iki.fi
/// WWW           : http://www.surina.net
///
////////////////////////////////////////////////////////////////////////////////
//
// $Id: jni-routines.cpp 222 2011-12-13 21:07:38Z olli $
//
////////////////////////////////////////////////////////////////////////////////

#include <jni.h>
#include <android/log.h>
//#include <string.h>
//#include <stdio.h>
//#include <dlfcn.h>

#include "../../../include/SoundTouch.h"
//#include "TimeShiftEffect.h"

#define LOGV(...)   __android_log_print((int)ANDROID_LOG_INFO, "SOUNDTOUCH", __VA_ARGS__)
//#define LOGV(...)


#define DLL_PUBLIC __attribute__ ((visibility ("default")))

using namespace soundtouch;

extern "C" DLL_PUBLIC jstring Java_net_surina_soundtouch_getVersionString(JNIEnv *env, jobject thiz)
{
    const char *verStr;

    LOGV("JNI call soundtouch.getVersionString");

    // Call example SoundTouch routine
    verStr = SoundTouch::getVersionString();

    // return version as string
    return env->NewStringUTF(verStr);
}
