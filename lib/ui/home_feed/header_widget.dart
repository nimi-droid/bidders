import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/models/user.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/strings.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/common/circular_image_view.dart';
import 'package:bidders/ui/leaderboard/leaderboard_page.dart';
import 'package:bidders/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeFeedHeader extends StatelessWidget {
  const HomeFeedHeader({Key key, this.user, this.onStartPollClicked}) : super(key: key);

  final AppUser user;
  final VoidCallback onStartPollClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Grappus',
                      style: tsRegular1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 7, right: 7),
                    margin: const EdgeInsets.only(left: 5),
                    decoration: const BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.all(Radius.circular(11))),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'BET',
                        style: tsRegular1,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: const BoxDecoration(
                      color: AppColors.whiteOpacity10,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    child: InkWell(
                      onTap: () {
                        Utils.showSuccessMessage(context, coming_soon);
                      },
                      child: const Icon(
                        Icons.account_balance_wallet,
                        color: AppColors.white,
                        size: 15,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteOpacity10,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: IconButton(
                        icon: const Icon(Icons.receipt, size: 15),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context, RouteAnimationSlideFromRight(widget: LeaderBoardPage()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 35),
          InkWell(
            onTap: onStartPollClicked,
            child: Row(
              children: [
                if (user == null)
                  Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white,
                      direction: ShimmerDirection.rtl,
                      period: const Duration(milliseconds: 1000),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ))
                else
                  CircularImageView(url: user.image, callBack: null),
                const SizedBox(width: 11),
                Text(hintStartPoll, style: tsRegular1.copyWith(color: AppColors.whiteOpacity70)),
                const SizedBox(width: 27),
              ],
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }
}
