import 'package:bidders/res/app_colors.dart';
import 'package:bidders/routes.dart';
import 'package:bidders/utils/log.dart';
import 'package:bidders/utils/shared_preferences.dart';
import 'package:bidders/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BiddersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _initDependencies();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.white,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveOverScrollGlow(),
          child: child,
        );
      },
      theme: Utils.getAppThemeData(),
      darkTheme: Utils.getAppThemeData(),
      themeMode: ThemeMode.light,
      initialRoute: RouteNames.splash,
      routes: routes,
    );
  }

  Future<void> _initDependencies() async {
    Log.init();
    await Prefs.init();
    await Firebase.initializeApp();
  }
}

class RemoveOverScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
