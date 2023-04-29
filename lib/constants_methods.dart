import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

const MaterialColor aquamarine = MaterialColor(
  _aquamarine,
  <int, Color>{
    50: Color(_aquamarine),
    100: Color(_aquamarine),
    200: Color(_aquamarine),
    300: Color(_aquamarine),
    400: Color(_aquamarine),
    500: Color(_aquamarine),
    600: Color(_aquamarine),
    700: Color(_aquamarine),
    800: Color(_aquamarine),
    900: Color(_aquamarine),
  },
);
const int _aquamarine = 0xFF77BFA3;

const MaterialColor lightSkyBlue = MaterialColor(
  _lightSkyBlue,
  <int, Color>{
    50: Color(_lightSkyBlue),
    100: Color(_lightSkyBlue),
    200: Color(_lightSkyBlue),
    300: Color(_lightSkyBlue),
    400: Color(_lightSkyBlue),
    500: Color(_lightSkyBlue),
    600: Color(_lightSkyBlue),
    700: Color(_lightSkyBlue),
    800: Color(_lightSkyBlue),
    900: Color(_lightSkyBlue),
  },
);
const int _lightSkyBlue = 0xFF85C7F2;

void showLoader(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => loader);
}

void showErrorSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

final loader =
    LoadingAnimationWidget.threeArchedCircle(color: aquamarine, size: 56);

String getMessage(double percentage) {
  if (percentage > .9) {
    return 'You are doing great, keep it up';
  } else if (percentage > .75) {
    return 'You have mantained good attendance';
  } else if (percentage >= .6) {
    return 'Your attandance is low, attend regular classes to manatain';
  } else {
    return 'Your attendance is too poor, please attend regular classes';
  }
}