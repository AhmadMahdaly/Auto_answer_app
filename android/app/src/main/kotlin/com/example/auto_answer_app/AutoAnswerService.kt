package com.example.auto_answer_app

import android.content.Context
import android.os.Build
import android.telecom.Call
import android.telecom.CallScreeningService
import android.telecom.CallScreeningService.CallResponse
import android.telecom.TelecomManager

class AutoAnswerService : CallScreeningService() {

    override fun onScreenCall(callDetails: Call.Details) {
        val response = CallResponse.Builder()
            .setDisallowCall(false) // السماح بالمكالمة
            .setRejectCall(false)   // عدم رفض المكالمة
            .setSilenceCall(false)  // عدم كتم المكالمة
            .build()

        respondToCall(callDetails, response)

        // محاولة الرد تلقائيًا على المكالمة
        answerCall()
    }

    private fun answerCall() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val telecomManager = getSystemService(Context.TELECOM_SERVICE) as TelecomManager?
            if (telecomManager != null) {
                try {
                    telecomManager.acceptRingingCall() // الرد على المكالمة
                } catch (e: SecurityException) {
                    e.printStackTrace()
                }
            }
        }
    }
}
