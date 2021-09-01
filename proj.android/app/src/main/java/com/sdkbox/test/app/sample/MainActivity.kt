package com.sdkbox.test.app.sample

import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private var tvLog: TextView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        tvLog = findViewById<TextView>(R.id.log)
        var button: Button? = findViewById<Button>(R.id.btnInit)
        button?.setOnClickListener {
            nativeInit()
        }
        button = findViewById<Button>(R.id.btnStart)
        button?.setOnClickListener {
            nativeSend2("", "", "")
        }
        button = findViewById<Button>(R.id.btnInteTest)
        button?.setOnClickListener {
            nativeSend1("", "", "")
        }
        button = findViewById<Button>(R.id.btnShowReward)
        button?.setOnClickListener {
            nativeSend3("", "", "")
        }
        button = findViewById<Button>(R.id.btnIsRewardCapped)
        button?.setOnClickListener {
            nativeSend4("", "", "")
        }
        button = findViewById<Button>(R.id.btnLoadInterstitial)
        button?.setOnClickListener {
            nativeSend5("", "", "")
        }
        button = findViewById<Button>(R.id.btnShowIntesitial)
        button?.setOnClickListener {
            nativeSend6("", "", "")
        }
        button = findViewById<Button>(R.id.btnLoadBanner)
        button?.setOnClickListener {
            nativeSend7("", "", "")
        }
        button = findViewById<Button>(R.id.btnDestoryBanner)
        button?.setOnClickListener {
            nativeSend8("", "", "")
        }

    }

    private fun log(s: String) {
        Log.d(TAG, "onRecv:$s")
        val txt = tvLog?.text.toString()
        var lines = txt.split("\n").toMutableList()
        while (lines.size > 4) {
            lines.removeAt(0)
        }
        lines.add(s)
        val sb = StringBuilder()
        for (i in lines.indices) {
            if (i > 0) {
                sb.append("\n")
            }
            sb.append(lines[i])
        }
        tvLog?.text = sb.toString()
    }

    fun onNativeRecv(s: String) {
        log(s)
    }

    private external fun nativeInit()
    private external fun nativeSend1(plugin: String, f: String, params: String)
    private external fun nativeSend2(plugin: String, f: String, params: String)
    private external fun nativeSend3(plugin: String, f: String, params: String)
    private external fun nativeSend4(plugin: String, f: String, params: String)
    private external fun nativeSend5(plugin: String, f: String, params: String)
    private external fun nativeSend6(plugin: String, f: String, params: String)
    private external fun nativeSend7(plugin: String, f: String, params: String)
    private external fun nativeSend8(plugin: String, f: String, params: String)
    private external fun nativeSend9(plugin: String, f: String, params: String)

    companion object {
        private val TAG: String = "MainActivity"
    }
}