package com.desktopecho.pideploy.receiver;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.desktopecho.pideploy.EnvUtils;

public class PowerReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(final Context context, Intent intent) {
        if (intent.getAction().equals(Intent.ACTION_SCREEN_OFF)) {
            EnvUtils.execService(context, "stop", "core/power");
        } else if (intent.getAction().equals(Intent.ACTION_SCREEN_ON)) {
            EnvUtils.execService(context, "start", "core/power");
        }
    }
}
