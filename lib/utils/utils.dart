import 'dart:async';

import 'package:bidders/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../custom_views/custom_overlays.dart';
import '../res/app_colors.dart';
import 'log.dart';

// ignore: avoid_classes_with_only_static_members
class Utils {
  static BuildContext _loaderContext;
  static bool _isLoaderShowing = false;
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

//  Checks
  static bool isNotEmpty(String s) {
    return s != null && s.trim().isNotEmpty;
  }

  static bool isEmpty(String s) {
    return !isNotEmpty(s);
  }

  static bool isListNotEmpty(List<dynamic> list) {
    return list != null && list.isNotEmpty;
  }

  //  Views
  static void showToast(BuildContext context, String message) {
    showCustomToast(context, message);
  }

  static void showSuccessMessage(BuildContext context, String message) {
    showCustomToast(context, message, bgColor: AppColors.snackBarGreen);
  }

  static void showNeutralMessage(BuildContext context, String message) {
    showCustomToast(context, message, bgColor: AppColors.snackBarColor);
  }

  static void showErrorMessage(BuildContext context, String message) {
    showCustomToast(context, message);
  }

  static void showValidationMessage(BuildContext context, String message) {
    Log.info('Toast message : ' + message);
    showCustomToast(context, message);
  }

  static void showCustomToast(BuildContext context, String message,
      {Color bgColor = AppColors.snackBarRed}) {
    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message, bgColor);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(const Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static void showLoader(BuildContext context, String message) {
    if (!_isLoaderShowing) {
      _isLoaderShowing = true;
      _loaderContext = context;
      showDialog(
          context: _loaderContext,
          barrierDismissible: false,
          builder: (context) {
            return SpinKitChasingDots(
              color: Colors.white,
            );
          }).then((value) => {_isLoaderShowing = false, Log.info('Loader hidden!')});
    }
  }

  static void hideLoader() {
    if (_isLoaderShowing) {
      Navigator.pop(_loaderContext);
      _loaderContext = null;
    }
  }

//  Misc
  static void dialPhoneNo(String phoneNo) {
    url_launcher.launch('tel://$phoneNo');
  }

  static void hideKeyBoard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static ThemeData getAppThemeData() {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          brightness: Brightness.light,
        ),
        canvasColor: Colors.transparent,
        primarySwatch: AppColors.primary_color,
        fontFamily: font_proxima,
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 32, color: AppColors.white, fontWeight: FontWeight.w700),
          headline2:
              TextStyle(fontSize: 28, color: AppColors.primary_color, fontWeight: FontWeight.w700),
          headline3: TextStyle(fontSize: 24, color: AppColors.white, fontWeight: FontWeight.w700),
          subtitle1: TextStyle(fontSize: 17, color: AppColors.white, fontWeight: FontWeight.w400),
          subtitle2: TextStyle(fontSize: 12, color: AppColors.white, fontWeight: FontWeight.w400),
        ));
  }

  static String getFormattedDate(String format, DateTime dateTime) {
    final DateFormat formatter = DateFormat(format);
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
}
