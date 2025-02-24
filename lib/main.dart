import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  requestMicrophonePermission();
  requestPermissions();
  setDefaultDialer();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    requestPermissions();
  }

  final stt.SpeechToText _speech = stt.SpeechToText();
  String _text = "اضغط للبدء...";
  FlutterTts tts = FlutterTts();

  void _speak(String text) async {
    await tts.speak(text);
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("تحويل الصوت إلى نص")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 300, child: Text(_text)),
              ElevatedButton(
                onPressed: _startListening,
                child: Text("ابدأ التسجيل"),
              ),
              ElevatedButton(
                onPressed: () {
                  _speak("آسف، لا أستطيع الرد الآن. من فضلك، أرسل لي رسالة.");
                },
                child: Text("رد تلقائي"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
