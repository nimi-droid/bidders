import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/models/create_poll_request.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/ui/home_feed_page.dart';
import 'package:bidders/utils/constants.dart';
import 'package:bidders/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../res/image_paths.dart';
import 'common/primary_button.dart';

class WohooPage extends StatelessWidget {
  /*WohooPage({DateTime dateTime}) {
    date = '${dateTime.day}/${dateTime.month}';
    time = '${dateTime.hour}:${dateTime.minute}';
  }*/

  WohooPage({Key key, this.createPollRequest}) : super(key: key);

  final CreatePollRequest createPollRequest;

  String date, time;
  double _screenHeight, _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    date = DateTimeUtils.convertStringToDateFormat(
        createPollRequest.startTime, KDateFormats.DATE_FORMAT_1);
    time = DateTimeUtils.convertStringToDateFormat(
        createPollRequest.startTime, KDateFormats.DATE_FORMAT_10);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: _screenWidth * 0.2,
          right: _screenWidth * 0.2,
          top: _screenHeight * 0.08,
          bottom: _screenHeight * 0.08,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(ic_purple_boxed_check),
                const SizedBox(height: 22),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Woohoo!',
                    style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 44),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Poll published, it will go live on $date at $time',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryButton(
                buttonText: 'Continue',
                onButtonPressed: () => _navigateToNextPage(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context, RouteAnimationSlideFromRight(widget: HomeFeedPage()), (route) => false);
  }
}
