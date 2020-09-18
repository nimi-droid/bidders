import 'dart:async';

import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/strings.dart';
import 'package:bidders/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

import '../../routes.dart';
import '../../utils/pref_utils.dart';
import '../home_feed_page.dart';
import '../login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var splashDuration = 1200;
  Timer _splashDurationTimer;
  final Duration _shimmerDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    startCountdownTimer();
    Utils.hideKeyBoard();
  }

  @override
  void dispose() {
    _splashDurationTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light
                .copyWith(systemNavigationBarColor: AppColors.primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: hero_grappus,
                      child: Stack(
                        children: [
                          //duplicated name rows to get the desired shimmer without affecting color and calculating position
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Opacity(
                                opacity: 0,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Grappus',
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 3, left: 7, right: 7),
                                decoration: const BoxDecoration(
                                  color: AppColors.blueColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(11)),
                                ),
                                child: Opacity(
                                  opacity: 0,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'BET',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: AppColors.charcoalGrey,
                            loop: 1,
                            period: _shimmerDuration,
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
                                const SizedBox(width: 10),
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5, left: 7, right: 7),
                                  decoration: BoxDecoration(
                                    color: AppColors.colorTransparent,
                                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: 'BET',
                                      style: Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  void startCountdownTimer() {
    final _duration = Duration(milliseconds: splashDuration);
    _splashDurationTimer = Timer(_duration, navigateToPage);
  }

  void navigateToPage() {
    Navigator.pushReplacement(
      context,
      RouteAnimationNone(
        widget: PrefUtils.getUserToken() != null ? HomeFeedPage() : LoginPage(),
        routeName: PrefUtils.getUserToken() != null ? RouteNames.home : RouteNames.login,
      ),
    );
  }
}
