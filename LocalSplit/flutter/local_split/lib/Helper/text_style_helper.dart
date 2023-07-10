import 'package:flutter/widgets.dart';
import 'package:local_split/Theme/color_theme.dart';
import 'package:local_split/Theme/font_theme.dart';

class TextStyleHelper {
  TextStyle get titleWithWhite => FontTheme().title.copyWith(
        color: ColorTheme().white,
        decoration: TextDecoration.none,
      );

  TextStyle get subTitleWithNavy => FontTheme().subTitle.copyWith(
        color: ColorTheme().navy,
        decoration: TextDecoration.none,
      );

  
  TextStyle get contentTitleWithNavy => FontTheme().content.copyWith(
        color: ColorTheme().navy,
        decoration: TextDecoration.none,
      );

  TextStyle get body2TitleWithNavy => FontTheme().content.copyWith(
        color: ColorTheme().navy,
        decoration: TextDecoration.none,
      );

  TextStyle get body2TitleWithGreen => FontTheme().content.copyWith(
        color: ColorTheme().navy,
        decoration: TextDecoration.none,
      );

  TextStyle get body3TitleWithNavy => FontTheme().content.copyWith(
        color: ColorTheme().navy,
        decoration: TextDecoration.none,
      );
}
