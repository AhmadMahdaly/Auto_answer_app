import 'package:auto_answer_app/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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

  void speak(String text) async {
    await tts.speak(text);
  }

  void startListening() async {
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

  final stt.SpeechToText _speech = stt.SpeechToText();
  String _text = "اضغط للبدء...";
  FlutterTts tts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("تحويل الصوت إلى نص")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: setDefaultDialer,
                  child: Text('تعيين التطبيق كمدير مكالمات افتراضي'),
                ),
              ),

              SizedBox(width: 300, child: Text(_text)),
              ElevatedButton(
                onPressed: startListening,
                child: Text("ابدأ التسجيل"),
              ),
              ElevatedButton(
                onPressed: () {
                  speak("آسف، لا أستطيع الرد الآن. من فضلك، أرسل لي رسالة.");
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
