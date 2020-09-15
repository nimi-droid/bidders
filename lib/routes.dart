import 'package:bidders/ui/common/splash.dart';
import 'package:bidders/ui/home_page.dart';
import 'package:bidders/ui/login_page.dart';
import 'package:flutter/material.dart';

///This class handles all the routes in the application
class RouteNames {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
}

final routes = <String, WidgetBuilder>{
  RouteNames.splash: (context) => SplashPage(),
  RouteNames.login: (context) => LoginPage(),
  RouteNames.home: (context) => HomePage(),
};
