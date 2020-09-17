import 'package:bidders/bloc/poll_bloc.dart';
import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/extensions/context_extension.dart';
import 'package:bidders/network/response/recent_people.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/strings.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/home_feed/user_info_widget.dart';
import 'package:bidders/ui/whats_about_page.dart';
import 'package:bidders/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common/circular_image_view.dart';
import 'common/stacked_images.dart';
import 'leaderboard/leaderboard_page.dart';

class HomeFeedPage extends StatefulWidget {
  @override
  _HomeFeedPageState createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  PollBloc _pollBloc;

  @override
  void initState() {
    super.initState();
    _pollBloc = PollBloc();
    /*_pollBloc.createPoll(
      options: [
        PollOption(statement: "FFDP", numberOfVotes: 0),
        PollOption(statement: "Alter Bridge", numberOfVotes: 0)
      ],
      description: "Best Band ever?",
      durationFromNow: DateTime.now().add(Duration(days: 1)),
      pollImage: "",
    );*/
    
    _pollBloc.fetchAllPolls();
  }

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
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              context.showBetAmountBottomSheet();
            },
            child: PollItem()),
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
                    child: Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet,
                          color: AppColors.white,
                          size: 15,
                        ),
                        const SizedBox(width: 9),
                        const Text("₹ 2,500", style: tsBoldWhite14)
                      ],
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
            onTap: () {
              startNewPoll(context);
            },
            child: Row(
              children: [
                const CircularImageView(url: sampleImageUrl, callBack: null),
                const SizedBox(width: 11),
                Text(hintStartPoll, style: tsRegular1.copyWith(color: AppColors.whiteOpacity30)),
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
          UserInfoWidget(
            sampleImageUrl,
            "Nimish Nandwana",
            "4 min ago",
            USER_INFO_TRAILING_WIDGET.poll,
            null,
          ),
          SizedBox(height: 20),
          Text(sampleQuestion, style: tsRegular1),
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
              backgroundColor: AppColors.whiteOpacity15,
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
}

const sampleQuestion = 'Which is the fastest framework for\ncross-platform app development?';
List<RecentPeople> getRecentPeopleList = [
  RecentPeople(null, "Nimish Wa,"),
  RecentPeople(null, "Archita s,"),
  RecentPeople(null, "P k,"),
];
