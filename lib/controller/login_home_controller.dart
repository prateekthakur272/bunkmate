import 'package:bunkmate/screens/homescreen.dart';
import 'package:bunkmate/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
class LoginHomeController extends StatelessWidget {
  const LoginHomeController({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return const HomeScreen();
        }
        return const LoginScreen();
      },
    );
  }
}