import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../res/image_paths.dart';
import 'common/primary_button.dart';

class WohooPage extends StatelessWidget {
  /*WohooPage({DateTime dateTime}) {
    date = '${dateTime.day}/${dateTime.month}';
    time = '${dateTime.hour}:${dateTime.minute}';
  }*/

  String date = '22/09', time = '10AM';
  double _screenHeight, _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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

  void _navigateToNextPage(BuildContext context) {}
}
