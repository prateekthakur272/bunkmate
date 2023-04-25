import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String hint;
  final TextInputType inputType;
  final IconData icon;
  final TextEditingController controller;
  final void Function(String)? onChange;
  const TextInput({super.key, required this.hint, required this.inputType, required this.icon, required this.controller, this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(icon: const Icon(Icons.cancel),onPressed: (){
          controller.clear();
          onChange!('');
        },),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
        )
      ),
    );
  }
}