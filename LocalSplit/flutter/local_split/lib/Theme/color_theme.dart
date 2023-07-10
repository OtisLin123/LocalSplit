import 'package:flutter/material.dart';

class ColorTheme {
  BuildContext? context;
  ColorTheme({this.context});

  bool get isDarkMode {
    if (context == null) {
      return false;
    }
    final brightness = MediaQuery.of(context!).platformBrightness;
    return brightness == Brightness.dark;
  }

  Color get white => const Color(0xFFFFFFFF);
  Color get darkGrey => const Color(0xFF818A99);
  Color get mediumGrey => const Color(0xFFA6AFBD);
  Color get darkGrey05 => const Color(0x7F818A99);
  Color get grey => const Color(0xFFE5E5EA);
  Color get navy => const Color(0xFF0D243F);
}
