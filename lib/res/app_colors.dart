import 'package:flutter/material.dart';

class AppColors extends MaterialColor {
  AppColors(int primary, Map<int, Color> swatch) : super(primary, swatch);

  static const int primaryColorValue = 0xFF1a416a;

  static const primaryColor = Color(0xff2f2f31);
  static const primaryColor10 = Color(0x1A1a416a);

  static const colorTransparent = Color(0x00000000);

  //Snackbar color
  static const snackBarColor = Color(0xff424242);
  static const snackBarRed = Color(0xffe53e3f);
  static const snackBarGreen = Color(0xff2dca73);

  //White shades
  static const white = Color(0xFFFFFFFF);
  static const white10 = Color(0x1AFFFFFF);
  static const white15 = Color(0x26ffffff);
  static const whiteOpacity20 = Color(0x33FFFFFF);
  static const whiteOpacity30 = Color(0x4DFFFFFF);
  static const whiteOpacity40 = Color(0x66FFFFFF);
  static const whiteOpacity50 = Color(0x80FFFFFF);
  static const whiteOpacity60 = Color(0x99FFFFFF);
  static const whiteOpacity70 = Color(0xB3FFFFFF);
  static const whiteOpacity80 = Color(0xCCFFFFFF);

  //Black shades
  static const black = Color(0xFF000000);
  static const black10 = Color(0x1A000000);

  //Grey Shades
  static const textGrey1 = Color(0xFF2a2e32);
  static const blueColor = Color(0xFF5458f7);
  static const charcoalGrey = Color(0xFF2f2f31);
  static const darkGrey = Color(0xFF191a1d);
  static const strongPink = Color(0xFFff0e83);

  static const Color primary_color = MaterialColor(primaryColorValue, <int, Color>{
    50: Color(primaryColorValue),
    100: Color(primaryColorValue),
    200: Color(primaryColorValue),
    300: Color(primaryColorValue),
    400: Color(primaryColorValue),
    500: Color(primaryColorValue),
    600: Color(primaryColorValue),
    700: Color(primaryColorValue),
    800: Color(primaryColorValue),
    900: Color(primaryColorValue),
  });
}
