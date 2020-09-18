import 'package:bidders/bloc/login_bloc.dart';
import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/custom_views/widget_animations.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/strings.dart';
import 'package:bidders/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../routes.dart';
import '../utils/pref_utils.dart';
import 'common/primary_button.dart';
import 'home_feed_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _screenWidth, _screenHeight;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    Utils.hideKeyBoard();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: _screenWidth * .11,
            right: _screenWidth * .11,
            top: _screenHeight * .092,
            bottom: _screenHeight * .08,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: hero_grappus,
                child: Stack(
                  children: [
                    //duplicated name rows to get the smooth hero transition
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Grappus',
                              style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 32),
                            ),
                          ),
                        ),
                        const SizedBox(width: 13),
                        Container(
                          padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 10),
                          decoration: const BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                          ),
                          child: Opacity(
                            opacity: 0,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'BET',
                                style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 32),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Grappus',
                            style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 32),
                          ),
                        ),
                        const SizedBox(width: 13),
                        Container(
                          padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 10),
                          decoration: const BoxDecoration(
                            color: AppColors.colorTransparent,
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'BET',
                              style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 32),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: _screenHeight * 0.1),
              FadeInAnimation(
                delay: 300,
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Log in to your account',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    SizedBox(
                      height: _screenHeight * .033,
                    ),
                    PrimaryButton(
                        buttonText: 'Continue with Google', onButtonPressed: _loginWithGoogle),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _loginWithGoogle() async {
    final User user = await signInWithGoogle();
    if (user != null) {
      navigateToHomePage();
    } else {
      print('Not validated');
      //TODO do something
    }
  }

  void navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      RouteAnimationSlideFromRight(
        widget: HomeFeedPage(),
        routeName: RouteNames.home,
      ),
    );
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    if (googleSignInAuthentication == null) {
      return null;
    }
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    Utils.showLoader(context);
    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    if (user != null) {
      //final User currentUser = _auth.currentUser;
      await _loginBloc
          .saveUserToFireStore(
              user, googleSignInAuthentication.accessToken, googleSignInAuthentication.idToken)
          .then((value) => PrefUtils.setUserToken(googleSignInAuthentication.accessToken));
      print('signInWithGoogle succeeded: $user');
      Utils.hideLoader();
      return user;
    }
    Utils.hideLoader();
    return null;
  }
}
