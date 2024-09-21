import 'package:courtone/user_auth/firebase_auth_impl/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'user_auth/firebase_auth_impl/firebase_auth_service.dart';
import 'Login.dart';
import 'Homepage.dart';
import 'Register.dart';
import 'BackgroundWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialisiere Firebase
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Hier wird die Login-Seite zuerst geladen
    );
  }
}


