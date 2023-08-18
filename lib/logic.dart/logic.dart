import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String splash1 = 'assets/splash1.png', splash2 = 'assets/splash2.png';

double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double percentage(double input, double percentage) {
  return (input / 100) * percentage;
}

void controlDeviceOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
