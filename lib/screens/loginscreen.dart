import 'package:bunkmate/auth/auth.dart';
import 'package:bunkmate/constants_methods.dart';
import 'package:bunkmate/widgets/start_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        elevation: 0,
      ),
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: double.infinity,
          decoration: const BoxDecoration(color: lightSkyBlue),
          padding: const EdgeInsets.all(24),
          child: Image.asset('assets/avtar.png'),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text(
                'Bunkmate',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text('Track lecture attandance'),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  StartIconButton(
                      icon: FontAwesomeIcons.google,
                      label: 'Sign in with Google',
                      onClick: () {
                        signInWithGoogle();
                      }
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
