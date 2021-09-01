package com.sdkbox.test.app.sample

import com.sdkbox.bb.bridge.core.Bridge

class App : com.sdkbox.bb.bridge.core.BApplication() {

    override fun onCreate() {
        Bridge.init(this)
        Bridge.newPlugin("com.sdkbox.bb.bridge.plugin.ironsource.PluginIronSource")
        super.onCreate()
    }

    companion object {
        init {
            System.loadLibrary("native-lib")
        }
    }
}
