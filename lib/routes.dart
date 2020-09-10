import 'package:bidders/ui/common/splash.dart';
import 'package:flutter/material.dart';

///This class handles all the routes in the application
class RouteNames {
  static const splash = '/';
}

final routes = <String, WidgetBuilder>{
  RouteNames.splash: (context) => SplashPage(),
};
