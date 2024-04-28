import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:llm_stethoscope/login.dart';
import 'package:llm_stethoscope/register.dart';
import 'package:llm_stethoscope/home.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => MyLogin(),
        'register': (context) => MyRegister(),
        'home':((context) => MyHome())
      },
    );
  }
}
