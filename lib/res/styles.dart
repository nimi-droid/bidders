import 'dart:io';

import 'package:flutter/material.dart';

import 'app_colors.dart';

final bool isIOS = Platform.isIOS;

/*Fonts*/
const font_proxima = 'Proxima';
const proximaRegular = FontWeight.w400;
const proximaMedium = FontWeight.w500;
const proximaSemiBold = FontWeight.w600;
const proximaBold = FontWeight.w700;

//Medium Styles
const tsMediumHeadingGrey1 =
    TextStyle(color: AppColors.textGrey1, fontSize: 22.0, fontWeight: proximaMedium);

//Bold Styles
const tsBoldButtonPrimary1 = TextStyle(
    color: AppColors.white, fontSize: 17.0, fontWeight: proximaBold, fontFamily: font_proxima);

const tsBoldDarkGrey = TextStyle(
    color: AppColors.darkGrey, fontSize: 17.0, fontWeight: proximaBold, fontFamily: font_proxima);

const tsBoldWhite14 = TextStyle(
    color: AppColors.white, fontSize: 14, fontWeight: proximaBold, fontFamily: font_proxima);

const tsBoldWhite12 = TextStyle(
    color: AppColors.white, fontSize: 12, fontWeight: proximaBold, fontFamily: font_proxima);

const tsBoldWhite10 = TextStyle(
    color: AppColors.white, fontSize: 10, fontWeight: proximaBold, fontFamily: font_proxima);
