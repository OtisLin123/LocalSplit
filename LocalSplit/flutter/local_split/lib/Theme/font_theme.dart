import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FontTheme {
  TextStyle get title => const TextStyle(
        fontSize: 17,
        fontFamily: "PingFang TC",
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      );

  TextStyle get subTitle => const TextStyle(
        fontSize: 15,
        fontFamily: "PingFang TC",
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.none,
      );

  TextStyle get content => const TextStyle(
        fontSize: 15,
        fontFamily: "PingFang TC",
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      );

  
  TextStyle get body2 => const TextStyle(
        fontSize: 15,
        fontFamily: "PingFang TC",
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      );
      
  TextStyle get body3 => const TextStyle(
        fontSize: 15,
        fontFamily: "PingFang TC",
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.none,
      );
}
