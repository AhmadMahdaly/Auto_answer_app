package com.example.auto_answer_app

import android.content.Context
import android.os.Build
import android.telecom.TelecomManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "auto_answer"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (call.method == "answerCall") {
                    val success = answerIncomingCall()
                    result.success(success)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun answerIncomingCall(): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val telecomManager = getSystemService(Context.TELECOM_SERVICE) as TelecomManager?
            if (telecomManager != null) {
                try {
                    telecomManager.acceptRingingCall() // الرد على المكالمة
                    return true
                } catch (e: SecurityException) {
                    e.printStackTrace()
                }
            }
        }
        return false
    }
}
