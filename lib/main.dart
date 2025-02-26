import 'package:auto_answer_app/functions.dart';
import 'package:auto_answer_app/my_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  requestMicrophonePermission();
  requestPermissions();
  setDefaultDialer();
  runApp(MyApp());
}
