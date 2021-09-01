#include <string>
#include <sstream>
#include <vector>
#include <thread>
#include <jni.h>
#include <android/log.h>
#include "PluginIronSource.h"

#define LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG, "Native", __VA_ARGS__)

static JavaVM *gJVM = nullptr;
static jobject mainActivity = nullptr;
static int counter = 0;
static pthread_key_t gThreadKey;
static bool bThreadRunning = true;

JNIEnv* cacheEnv() {
    if (nullptr == gJVM) {
        return nullptr;
    }
    JNIEnv* env = nullptr;
    jint ret = gJVM->GetEnv((void**)&env, JNI_VERSION_1_4);
    switch (ret) {
        case JNI_OK: {
            pthread_setspecific(gThreadKey, env);
            break;
        }
        case JNI_EDETACHED: {
            if (gJVM->AttachCurrentThread(&env, nullptr) >= 0) {
                pthread_setspecific(gThreadKey, env);
            }
            break;
        }
    }

    return env;
}

JNIEnv* getEnv() {
    JNIEnv* env = (JNIEnv*)pthread_getspecific(gThreadKey);
    if (nullptr != env) {
        return env;
    }
    return cacheEnv();
}

void notifyToJava(const std::string& evt) {
    JNIEnv* env = getEnv();
    if (nullptr == env) {
        LOGD("env is null");
        return;
    }
    if (nullptr == mainActivity) {
        return;
    }

    jclass clazz = env->GetObjectClass(mainActivity);
    jmethodID method = env->GetMethodID(clazz, "onNativeRecv", "(Ljava/lang/String;)V");
    if (nullptr == method) {
        return;
    }
    env->CallVoidMethod(mainActivity, method, env->NewStringUTF(evt.c_str()));
}

void testThread() {
    while (bThreadRunning) {
        std::this_thread::sleep_for(std::chrono::seconds(10));

        std::string s = "native callback:";
        s += std::to_string(++counter);
        notifyToJava(s);
    }
}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeInit(JNIEnv *env, jobject thiz) {
    env->GetJavaVM(&gJVM);
    if (nullptr != mainActivity) {
        env->DeleteGlobalRef(mainActivity);
        mainActivity = nullptr;
    }
    mainActivity = env->NewGlobalRef(thiz);

    sdkbox::bb::plugin::IronSource::init();
    sdkbox::bb::plugin::IronSource::setListener([](const std::string& evt, const std::string& json) {
        std::stringstream ss;
        ss << "IS evt:" << evt << " json:" << json;
        notifyToJava(ss.str());
    });




}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeSend1(JNIEnv *env, jobject thiz, jstring jplugin, jstring jfunc, jstring jparams) {

    sdkbox::bb::plugin::IronSource::validateIntegration();
}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeSend2(JNIEnv *env, jobject thiz, jstring jplugin, jstring jfunc, jstring jparams) {
    sdkbox::bb::plugin::IronSource::setMetaData("k1", "v1");
    sdkbox::bb::plugin::IronSource::setUserId("uid10001");
    sdkbox::bb::plugin::IronSource::setConsent(true);
    sdkbox::bb::plugin::IronSource::setSegment("");
    sdkbox::bb::plugin::IronSource::setRewardedVideoServerParameters({});
    sdkbox::bb::plugin::IronSource::clearRewardedVideoServerParameters();
    sdkbox::bb::plugin::IronSource::setOfferwallCustomParams({});
    sdkbox::bb::plugin::IronSource::shouldTrackNetworkState(true);

    sdkbox::bb::plugin::IronSource::setDynamicUserId("dynuid10001");

    sdkbox::bb::plugin::IronSource::getOfferwallCredits();
    sdkbox::bb::plugin::IronSource::setClientSideCallbacks(true);

    // "10b5adc55"
    sdkbox::bb::plugin::IronSource::launch("10b5adc55");
}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeSend3(JNIEnv *env, jobject thiz, jstring jplugin, jstring jfunc, jstring jparams) {
    sdkbox::bb::plugin::IronSource::isRewardedVideoAvailable([](bool b) {
        std::stringstream ss;
        ss << "Rewarded Video Available:" << b;
        notifyToJava(ss.str());

        sdkbox::bb::plugin::IronSource::showRewardedVideo("");
    }, "");

}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeSend4(JNIEnv *env, jobject thiz, jstring jplugin, jstring jfunc, jstring jparams) {

    sdkbox::bb::plugin::IronSource::isRewardedVideoPlacementCapped([](bool b) {
        std::stringstream ss;
        ss << "Rewarded Video Capped:" << b;
        notifyToJava(ss.str());
    }, "");

}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeSend5(JNIEnv *env, jobject thiz, jstring jplugin, jstring jfunc, jstring jparams) {
    sdkbox::bb::plugin::IronSource::loadInterstitial();
}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeSend6(JNIEnv *env, jobject thiz, jstring jplugin, jstring jfunc, jstring jparams) {
    sdkbox::bb::plugin::IronSource::isInterstitialReady([](bool b) {
        std::stringstream ss;
        ss << "Interstitial Ready:" << b;
        notifyToJava(ss.str());
        sdkbox::bb::plugin::IronSource::showInterstitial("");
    }, "");

//    sdkbox::bb::plugin::IronSource::isInterstitialPlacementCapped([](bool b) {
//        std::stringstream ss;
//        ss << "Interstitial Capped:" << b;
//        notifyToJava(ss.str());
//    }, "");

}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeSend7(JNIEnv *env, jobject thiz, jstring jplugin, jstring jfunc, jstring jparams) {
    sdkbox::bb::plugin::IronSource::loadBanner("");
}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeSend8(JNIEnv *env, jobject thiz, jstring jplugin, jstring jfunc, jstring jparams) {
    sdkbox::bb::plugin::IronSource::destroyBanner();
}

extern "C"
JNIEXPORT void JNICALL
Java_com_sdkbox_test_app_sample_MainActivity_nativeSend9(JNIEnv *env, jobject thiz, jstring jplugin, jstring jfunc, jstring jparams) {
    sdkbox::bb::plugin::IronSource::showOfferwall();
}
