
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:llm_stethoscope/login.dart';
import 'package:llm_stethoscope/register.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context)=>MyLogin(),
      'register':(context)=>MyRegister(),
    },
  ));
}