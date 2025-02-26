import 'package:flutter/services.dart';

import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  await Permission.phone.request();
}

Future<void> requestMicrophonePermission() async {
  var status = await Permission.microphone.request();
  if (status.isGranted) {
    print("تم منح إذن الميكروفون!");
  } else {
    print("تم رفض إذن الميكروفون!");
  }
}

Future<void> setDefaultDialer() async {
  try {
    const platform = MethodChannel('auto_answer');
    await platform.invokeMethod('setDefaultDialer');
  } on PlatformException catch (e) {
    print("حدث خطأ: ${e.message}");
  }
}
