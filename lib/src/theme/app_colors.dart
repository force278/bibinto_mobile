import 'package:flutter/material.dart';

/// Класс, описывающий основные цвета [Color], используемые в приложении
abstract class AppColors {
  /// Стандартный белый цвет
  static const int _themeWhiteAccentValue = 0xffffffff;

  /// Белый accent цвет
  static const MaterialAccentColor themeWhite = MaterialAccentColor(
    _themeWhiteAccentValue,
    <int, Color>{
      100: Color(0xffffffff),
      200: Color(_themeWhiteAccentValue),
      400: Color(0xfffbfbfb),
      700: Color(0xfff3f3f3),
    },
  );

  static const Color beige = Color(0xffF6F0E5);

  static const Color orange = Color(0xffF6C66D);

  static const Color grey = Color(0xff7D7D7D);

  static const Color borderColor = Color(0xff8E8E93);

  static const Color shimmerColor = Color.fromARGB(255, 198, 198, 206);

  static const Color shimmerHighlightColor = Color.fromARGB(255, 190, 190, 199);

  static const Color disabledColor = Color(0xffC4C4C4);

  static const Color disabledIconColor = Color(0xffF3F3F3);
}
