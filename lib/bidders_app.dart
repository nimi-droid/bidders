import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'res/app_colors.dart';
import 'routes.dart';
import 'utils/log.dart';
import 'utils/pref_utils.dart';
import 'utils/utils.dart';

class BiddersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _initDependencies();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.primaryColor,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
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
    await PrefUtils.init();
    await Firebase.initializeApp();
  }
}

class RemoveOverScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
