import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hint;
  final TextInputType inputType;
  final IconData icon;
  const TextInput({super.key, required this.hint, required this.inputType, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
        )
      ),
    );
  }
}