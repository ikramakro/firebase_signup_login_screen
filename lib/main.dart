import 'package:flutter/material.dart';
import 'package:untitled/Screen/Splash_Screen.dart';
import 'Screen/FristScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:SplashScreen()
    );
  }
}
