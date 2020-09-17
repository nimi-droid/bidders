import 'package:bidders/bloc/poll_bloc.dart';
import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/models/poll.dart';
import 'package:bidders/network/response/recent_people.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/strings.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/home_feed/user_info_widget.dart';
import 'package:bidders/ui/whats_about_page.dart';
import 'package:bidders/utils/constants.dart';
import 'package:bidders/utils/date_time_utils.dart';
import 'package:bidders/utils/utils.dart';
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
      child: StreamBuilder<List<Poll>>(
          stream: _pollBloc.getPollsListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    PollItem(poll: snapshot.data[index], voteOnPoll: onPollItemClicked),
              );
            } else {
              return Container();
            }
          }),
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

  void onPollItemClicked(String pollId, int choice, int pollPosition) {
//    Utils.showLoader(context);
//    _pollBloc.voteOnAPoll(pollId, choice, pollPosition);
    Utils.showSuccessMessage(context, 'coming soon');
  }
}

class PollItem extends StatelessWidget {
  const PollItem({Key key, this.poll, this.voteOnPoll, this.itemPosition}) : super(key: key);

  final Poll poll;
  final Function(String pollId, int choice, int itemPosition) voteOnPoll;
  final int itemPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGrey,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoWidget(
            poll.user.userImage,
            poll.user.userName,
            DateTimeUtils.timeAgoSinceDate(poll.createdAt),
            USER_INFO_TRAILING_WIDGET.poll,
            null,
          ),
          const SizedBox(height: 20),
          Text(poll.description, style: tsRegular1),
          const SizedBox(height: 17),
          getPollPercentageIndicator(),
          const SizedBox(height: 40),
          StackedImagesVotesAndTimeLeft(votes: 4, recentPeople: getRecentPeopleList, timeLeft: 6)
        ],
      ),
    );
  }

  Widget getPollPercentageIndicator() {
    int totalParticipation = 0;

    for (int i = 0; i < poll.options.length; i++) {
      totalParticipation += poll.options[i].numberOfVotes;
    }

    return ListView.separated(
      itemCount: poll.options.length,
      shrinkWrap: true,
      separatorBuilder: (context, position) => const SizedBox(height: 15),
      itemBuilder: (context, position) => PollsPercentItem(
        pollOption: poll.options[position],
        ishigestVoted: true,
        totalPollParticipantCount: totalParticipation,
        showResults: poll.hasVoted,
        position: position,
        onItemClick: onOptionSelected,
      ),
    );
  }

  void onOptionSelected(int position) {
    if (poll.hasVoted) {
      return;
    }

    voteOnPoll(poll.id, position, itemPosition);
  }
}

class PollsPercentItem extends StatelessWidget {
  const PollsPercentItem(
      {Key key,
      this.pollOption,
      this.totalPollParticipantCount,
      this.ishigestVoted,
      this.showResults,
      this.position,
      this.onItemClick})
      : super(key: key);

  final PollOption pollOption;
  final int totalPollParticipantCount;
  final bool ishigestVoted;
  final bool showResults;
  final int position;
  final Function(int position) onItemClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick(position);
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: 38,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: LinearProgressIndicator(
                value: pollOption.numberOfVotes != 0
                    ? pollOption.numberOfVotes / totalPollParticipantCount
                    : 0,
                valueColor: AlwaysStoppedAnimation<Color>(
                    ishigestVoted ? AppColors.white : AppColors.whiteOpacity30),
                backgroundColor: AppColors.whiteOpacity15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: showResults
                ? Text(
                    '${pollOption?.statement} (${pollOption.numberOfVotes ~/ totalPollParticipantCount * 100}%)',
                    style: tsBoldDarkGrey)
                : Text(pollOption?.statement, style: tsRegular1),
          )
        ],
      ),
    );
  }
}

const sampleQuestion = 'Which is the fastest framework for\ncross-platform app development?';
List<RecentPeople> getRecentPeopleList = [
  RecentPeople(null, "Nimish Wa,"),
  RecentPeople(null, "Archita s,"),
  RecentPeople(null, "P k,"),
];
