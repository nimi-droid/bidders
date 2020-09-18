import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'custom_cupertino_page_transition.dart';

class BasePageRouteBuilder extends PageRouteBuilder {
  BasePageRouteBuilder({this.routeName});

  final String routeName;

  @override
  RouteSettings get settings {
    if (Utils.isEmpty(routeName)) {
      return super.settings;
    } else {
      return RouteSettings(
        name: routeName,
        arguments: super.settings.arguments,
      );
    }
  }
}

class RouteAnimationNone extends PageRouteBuilder {
  RouteAnimationNone({@required this.widget, this.routeName})
      : super(pageBuilder: (context, animation, secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        });

  final Widget widget;
  final String routeName;

  @override
  RouteSettings get settings {
    if (Utils.isEmpty(routeName)) {
      return super.settings;
    } else {
      return RouteSettings(
        name: routeName,
        arguments: super.settings.arguments,
      );
    }
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}

class RouteAnimationNoneWithDuration extends PageRouteBuilder {
  RouteAnimationNoneWithDuration({@required this.widget, @required this.animDuration})
      : super(pageBuilder: (context, animation, secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        });

  final Widget widget;
  final int animDuration;

  @override
  Duration get transitionDuration => Duration(milliseconds: animDuration);
}

class RouteAnimationSlideFromRight extends PageRouteBuilder {
  RouteAnimationSlideFromRight({
    this.widget,
    this.routeName,
    this.shouldMaintainState = true,
  }) : super(pageBuilder: (context, animation, secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return CustomCupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            child: child,
            linearTransition: false,
            isSlideFromRight: true,
          );
        });

  final Widget widget;
  final String routeName;
  final bool shouldMaintainState;

  @override
  RouteSettings get settings {
    if (Utils.isEmpty(routeName)) {
      return super.settings;
    } else {
      return RouteSettings(
        name: routeName,
        arguments: super.settings.arguments,
      );
    }
  }

  @override
  bool get maintainState {
    return shouldMaintainState;
  }
}

class RouteAnimationFadeIn extends PageRouteBuilder {
  RouteAnimationFadeIn(this.widget, {this.shouldMaintainState = false, this.routeName})
      : super(pageBuilder: (context, animation, secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });

  final Widget widget;
  final String routeName;
  final bool shouldMaintainState;

  @override
  bool get maintainState {
    return shouldMaintainState;
  }

  @override
  RouteSettings get settings {
    if (Utils.isEmpty(routeName)) {
      return super.settings;
    } else {
      return RouteSettings(
        name: routeName,
        arguments: super.settings.arguments,
      );
    }
  }
}

class RouteAnimationCupertinoSlideFromBottom extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  final bool shouldMaintainState;
  final bool shouldDisableExitAnimation;

  RouteAnimationCupertinoSlideFromBottom({
    @required this.widget,
    this.routeName,
    this.shouldMaintainState = true,
    this.shouldDisableExitAnimation = false,
  }) : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return CustomCupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            child: child,
            linearTransition: false,
            shouldDisableExitAnimation: shouldDisableExitAnimation,
          );
        });

  @override
  RouteSettings get settings {
    if (Utils.isEmpty(routeName))
      return super.settings;
    else
      return RouteSettings(
        name: routeName,
        arguments: super.settings.arguments,
      );
  }

  @override
  bool get maintainState {
    return shouldMaintainState;
  }
}
