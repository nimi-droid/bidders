import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/network/response/recent_people.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/strings.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/whats_about_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common/circular_image_view.dart';
import 'common/stacked_images.dart';

class HomeFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.charcoalGrey,
      body: SafeArea(
        child: Column(
          children: [getHeaderWidget(context), getPollWidget()],
        ),
      ),
    );
  }

  Widget getPollWidget() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) => PollItem(),
      ),
    );
  }

  Widget getHeaderWidget(BuildContext context) {
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
                      style: tsBoldButtonPrimary1,
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
                        style: tsBoldButtonPrimary1,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                decoration: const BoxDecoration(
                  color: AppColors.white10,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                // ignore: prefer_const_literals_to_create_immutables
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      color: AppColors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 9),
                    const Text("₹ 2,500", style: tsBoldWhite14)
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 35),
          InkWell(
            onTap: () {
              startNewPoll(context);
            },
            child: Row(
              children: [
                CircularImageView(url: sampleImageUrl, callBack: null),
                const SizedBox(width: 11),
                Text(hintStartPoll,
                    style: tsBoldButtonPrimary1.copyWith(color: AppColors.whiteOpacity30)),
                const SizedBox(width: 27),
              ],
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }

  void startNewPoll(BuildContext context) {
    Navigator.pushReplacement(
      context,
      RouteAnimationSlideFromRight(
        widget: WhatsAboutPage(),
      ),
    );
  }
}

class PollItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGrey,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          informationWidget(sampleImageUrl, "Nimish Nandwana", "4 min ago"),
          SizedBox(height: 20),
          Text(sampleQuestion, style: tsBoldButtonPrimary1),
          SizedBox(height: 17),
          getPollPercentageIndicator(),
          SizedBox(height: 40),
          StackedImagesVotesAndTimeLeft(votes: 4, recentPeople: getRecentPeopleList, timeLeft: 6)
        ],
      ),
    );
  }

  Widget getPollPercentageIndicator() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 38,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: LinearProgressIndicator(
              value: 0.7,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              backgroundColor: AppColors.white15,
            ),
          ),
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Text('Flutter (70%)', style: tsBoldDarkGrey),
        )
      ],
    );
  }

  Widget informationWidget(String imageUrl, String heading, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              CircularImageView(url: imageUrl, callBack: null),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(heading, style: tsBoldWhite14),
                    Text(value, style: tsBoldWhite12.copyWith(color: AppColors.whiteOpacity60)),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 6),
          padding: const EdgeInsets.only(top: 3, bottom: 3, left: 13, right: 13),
          decoration: const BoxDecoration(
            color: AppColors.strongPink,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: const Text('POLL', style: tsBoldWhite10),
        )
      ],
    );
  }
}

const sampleImageUrl = 'https://icon2.cleanpng'
    '.com/20190304/yjt/kisspng-shinnosuke-nohara-video-crayon-shin-chan-nene-saku-shinchan-heart-anime-j-5c7cba96b08d02.6422473215516781027232.jpg';

const sampleQuestion = 'Which is the fastest framework for\ncross-platform app development?';
List<RecentPeople> getRecentPeopleList = [
  RecentPeople(null, "Nimish Wa,"),
  RecentPeople(null, "Archita s,"),
  RecentPeople(null, "P k,"),
];
