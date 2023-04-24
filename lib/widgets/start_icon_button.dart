import 'package:flutter/material.dart';

class StartIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function() onClick;
  const StartIconButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClick,
        
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 8,),
            Text(label),
          ],
        ),
    );
  }
}
