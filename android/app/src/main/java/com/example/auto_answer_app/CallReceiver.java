package com.example.auto_answer_app;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.telecom.TelecomManager;
import android.telephony.TelephonyManager;
import java.lang.reflect.Method;

public class CallReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent.getStringExtra(TelephonyManager.EXTRA_STATE).equals(TelephonyManager.EXTRA_STATE_RINGING)) {
            TelecomManager telecomManager = (TelecomManager) context.getSystemService(Context.TELECOM_SERVICE);
            if (telecomManager != null) {
                try {
                    Method method = telecomManager.getClass().getDeclaredMethod("acceptRingingCall");
                    method.setAccessible(true);
                    method.invoke(telecomManager);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
