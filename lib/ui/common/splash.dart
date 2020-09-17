import 'dart:async';

import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../utils/pref_utils.dart';
import '../home_feed_page.dart';
import '../login_page.dart';

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
        backgroundColor: AppColors.primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Grappus',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 7, right: 7),
                    margin: const EdgeInsets.only(left: 5),
                    decoration: const BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.all(Radius.circular(11))),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'BET',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  )
                ],
              )),
            ),
          ],
        ));
  }

  Future<Timer> startCountdownTimer() async {
    final _duration = Duration(milliseconds: splashDuration);
    return Timer(_duration, navigateToPage);
  }

  void navigateToPage() {
    Navigator.pushReplacement(
      context,
      RouteAnimationSlideFromRight(
        widget: PrefUtils.getUserToken() != null ? HomeFeedPage() : LoginPage(),
        routeName: PrefUtils.getUserToken() != null ? RouteNames.home : RouteNames.login,
      ),
    );
  }
}
