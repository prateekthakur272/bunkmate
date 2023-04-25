import 'package:bunkmate/constants_methods.dart';
import 'package:bunkmate/controller/login_home_controller.dart';
import 'package:bunkmate/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('User profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24,left: 24,right: 24),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: aquamarine,
                foregroundImage: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL??''),
              ),
              const SizedBox(height: 16,),
              Text(FirebaseAuth.instance.currentUser?.displayName??'',style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              Text(FirebaseAuth.instance.currentUser?.email??'',style: const TextStyle(fontSize: 16),),
              const SizedBox(height: 8,),
              const Divider(),
              const SizedBox(height: 8,),
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){
                FirebaseAuth.instance.signOut().then((value) => Navigator.popUntil(context, (route) => route.isFirst));
              }, child: const Text('Sign out')),)
            ],
          ),
        ),
      )
    );
  }
}