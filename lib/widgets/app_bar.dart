import 'package:flutter/material.dart';

AppBar appBar(String title,[List<Widget>? actions]) {
  return AppBar(
    title: Text(title),
    actions: actions,
  );
}
