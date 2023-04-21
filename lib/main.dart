import 'package:flutter/material.dart';

void main() {
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
        primarySwatch: Colors.blue,
      ),
      home: const Placeholder()
    );
  }
}
