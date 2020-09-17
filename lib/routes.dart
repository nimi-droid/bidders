import 'package:flutter/material.dart';

import 'ui/common/splash.dart';
import 'ui/date_time_page.dart';
import 'ui/home_page.dart';
import 'ui/login_page.dart';
import 'ui/my_bets_page.dart';
import 'ui/whats_about_page.dart';
import 'ui/whats_new_page.dart';
import 'ui/wohoo_page.dart';

///This class handles all the routes in the application
class RouteNames {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const whatsNext = '/whatsNext';
  static const dateTime = '/dateTime';
  static const wohoo = "/wohoo";
  static const whatsNew = '/whatsNew';
  static const myBets = '/myBets';
}

final routes = <String, WidgetBuilder>{
  RouteNames.splash: (context) => SplashPage(),
  RouteNames.login: (context) => LoginPage(),
  RouteNames.home: (context) => HomePage(),
  RouteNames.whatsNext: (context) => WhatsAboutPage(),
  RouteNames.dateTime: (context) => DateTimePage(),
  RouteNames.wohoo: (context) => WohooPage(),
  RouteNames.whatsNew: (context) => WhatsNewPage(),
  RouteNames.myBets: (context) => MyBetsPage()
};
