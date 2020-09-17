import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom_views/route_animations.dart';
import '../res/app_colors.dart';
import '../res/image_paths.dart';
import '../res/strings.dart';
import '../routes.dart';
import 'common/primary_button.dart';
import 'home_page.dart';

class WhatsNewPage extends StatelessWidget {
  double _screenWidth, _screenHeight;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        padding: EdgeInsets.only(
          left: _screenWidth * 0.141,
          right: _screenWidth * 0.141,
          bottom: _screenHeight * 0.08,
          top: _screenHeight * 0.161,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: heading_whats_new,
                style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 44),
              ),
            ),
            SizedBox(height: _screenHeight * 0.038),
            _item(context, ic_purple_boxed_check, label_title_1, label_subtitle_1),
            SizedBox(height: _screenHeight * 0.038),
            _item(context, ic_purple_boxed_check, label_title_2, label_subtitle_2),
            SizedBox(height: _screenHeight * 0.038),
            _item(context, ic_purple_boxed_check, label_title_3, label_subtitle_3),
            const Expanded(child: SizedBox()),
            PrimaryButton(
              buttonText: btn_lets_go,
              onButtonPressed: () => _navigateToHomeScreen(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, String image, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: title,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: subtitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      RouteAnimationSlideFromRight(
        widget: HomePage(),
        routeName: RouteNames.home,
      ),
    );
  }
}
