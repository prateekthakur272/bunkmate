import 'package:bunkmate/widgets/app_bar.dart';
import 'package:bunkmate/widgets/overall_attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('User profile'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage('assets/profile.png'),
                  foregroundImage: NetworkImage(
                      FirebaseAuth.instance.currentUser?.photoURL ?? ''),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 24,
                ),
                const OverallAttendance(),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(16))
                                ),
                                title: const Text('Sign out'),
                                content: const Text(
                                    'Do you want to sign out bunkmate'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut().then(
                                            (value) => Navigator.popUntil(
                                                context,
                                                (route) => route.isFirst));
                                      },
                                      child: const Text('Sign out')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel')),
                                ],
                              );
                            }));
                      },
                      child: const Text('Sign out')),
                )
              ],
            ),
          ),
        ));
  }
}
