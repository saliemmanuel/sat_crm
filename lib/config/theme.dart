import 'package:flutter/material.dart';
import 'package:sat_crm/config/palette.dart';

class ThemeApp {
  static lightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Palette.primaryColor,
          brightness: Brightness.light,
          primary: Palette.primaryColor),
      useMaterial3: true,
    );
  }
}
