import 'package:bunkmate/constants_methods.dart';
import 'package:bunkmate/firebase_options.dart';
import 'package:bunkmate/screens/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bunkmate',
      theme: ThemeData(
        canvasColor: Colors.white,
        primarySwatch: primaryBlack
      ),
      darkTheme: ThemeData(
        primarySwatch: primaryBlack,
        canvasColor: Colors.black87
      ),
      home: const HomeScreen()
    );
  }
}
