import 'package:bidders/models/user.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/dimens.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/common/app_toolbar.dart';
import 'package:bidders/ui/common/circular_image_view.dart';
import 'package:bidders/utils/constants.dart';
import 'package:flutter/material.dart';

class LeaderBoardPage extends StatelessWidget {
  final _itemCount = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalGrey,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 30),
            AppToolbar(
              title: 'Leaderboard',
              onTrailingBtnPressed: () {
                Navigator.pop(context);
              },
            ),
            // TopThree(),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.margin_screen_left_right,
                    vertical: Dimens.margin_screen_left_right - 10,
                  ),
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SingleUserStandingWidget(
                        position,
                        User(name: 'Mayank', walletBalance: 500),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class TopThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SingleUserStandingWidget extends StatelessWidget {
  final int position;
  final User user;

  const SingleUserStandingWidget(this.position, this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          RichText(
            text: TextSpan(text: (position + 1).toString().padLeft(2, '0'), style: tsBoldWhite14),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 17),
              decoration: BoxDecoration(
                color: AppColors.whiteOpacity15,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularImageView(
                      url: sampleImageUrl, callBack: null, height: 48, width: 48),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: RichText(
                            text: TextSpan(
                              text: user.name,
                              style: tsBoldDarkGrey.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: RichText(
                            text: TextSpan(
                              text: '₹ ${user.walletBalance}',
                              style: tsBoldDarkGrey.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
