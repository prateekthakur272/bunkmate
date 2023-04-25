import 'package:bunkmate/widgets/app_bar.dart';
import 'package:flutter/material.dart';
class SelectedItem extends StatefulWidget {
  final String title;
  final Map<String,dynamic> record;
  const SelectedItem({super.key, required this.title, required this.record});

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.title),
    );
  }
}