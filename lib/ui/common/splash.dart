import 'dart:async';

import 'package:bidders/res/app_colors.dart';
import 'package:bidders/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var splashDuration = 1500;

  @override
  void initState() {
    super.initState();
    startCountdownTimer();
    Utils.hideKeyBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(child: Icon(Icons.ac_unit)),
              ),
            ),
          ],
        ));
  }

  Future<Timer> startCountdownTimer() async {
    final _duration = Duration(milliseconds: splashDuration);
    return Timer(_duration, navigateToPage);
  }

  void navigateToPage() {
    Utils.showSuccessMessage(context, 'Time over do something');
  }
}
