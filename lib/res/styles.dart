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
    TextStyle(color: AppColors.textGrey1, fontSize: 22.0, fontWeight: FontWeight.w500);

//Bold Styles
const tsBoldButtonPrimary1 =
    TextStyle(color: AppColors.textGrey1, fontSize: 18.0, fontWeight: FontWeight.w700);
