import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/dimens.dart';
import 'package:bidders/res/strings.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/common/primary_button.dart';
import 'package:bidders/ui/home_feed/user_info_widget.dart';
import 'package:flutter/material.dart';

import '../home_feed_page.dart';

const BET_INCREMENT_VALUE = 50;

class BetAmountBottomSheet extends StatefulWidget {
  @override
  _BetAmountBottomSheetState createState() => _BetAmountBottomSheetState();
}

class _BetAmountBottomSheetState extends State<BetAmountBottomSheet> {
  int _betAmount = 0;
  final int _maxBetAmount = 530;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimens.bottom_sheet_corner_radius),
        ),
        color: AppColors.charcoalGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.margin_screen_left_right),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: Dimens.margin_screen_left_right,
                right: Dimens.margin_screen_left_right - 5,
              ),
              child: UserInfoWidget(
                sampleImageUrl,
                'Nimish Nandwana',
                '4 min ago',
                USER_INFO_TRAILING_WIDGET.cross,
                () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.margin_screen_left_right),
              child: RichText(
                text: const TextSpan(
                  text: 'Which is the fastest framework for cross-platform app development?',
                  style: tsRegular1,
                ),
              ),
            ),

            //Amount and option
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.margin_screen_left_right),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '₹ $_betAmount',
                          style: tsBold1,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Chelsea @ 1:3',
                          style: tsRegular1.copyWith(color: AppColors.whiteOpacity30),
                        ),
                      ),
                    ],
                  ),
                  //Increment buttons
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.charcoalGrey2),
                        width: 48,
                        child: IconButton(
                          icon: const Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              if (_betAmount + BET_INCREMENT_VALUE < _maxBetAmount)
                                _betAmount += BET_INCREMENT_VALUE;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.charcoalGrey2),
                        width: 48,
                        child: IconButton(
                          icon: const Icon(Icons.remove, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              if (_betAmount > 0) _betAmount -= BET_INCREMENT_VALUE;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: Dimens.margin_screen_left_right,
                right: Dimens.margin_screen_left_right,
                top: 40,
              ),
              child: AnimatedOpacity(
                opacity: _betAmount > 0 ? 1 : 0.4,
                duration: const Duration(milliseconds: 150),
                child: PrimaryButton(
                  buttonText: submit,
                  onButtonPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
