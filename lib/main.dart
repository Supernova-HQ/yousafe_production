import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yousafe/firebase_options.dart';
import 'package:yousafe/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}