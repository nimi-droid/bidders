import 'dart:async';

import 'package:bidders/bloc/poll_bloc.dart';
import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/extensions/context_extension.dart';
import 'package:bidders/models/poll.dart';
import 'package:bidders/models/user.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/home_feed/header_widget.dart';
import 'package:bidders/ui/home_feed/user_info_widget.dart';
import 'package:bidders/ui/whats_about_page.dart';
import 'package:bidders/utils/date_time_utils.dart';
import 'package:bidders/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'common/stacked_images.dart';

class HomeFeedPage extends StatefulWidget {
  @override
  _HomeFeedPageState createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  PollBloc _pollBloc;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    _pollBloc.fetchAllPolls();
    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    _pollBloc.fetchAllPolls();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _pollBloc = PollBloc();
    _pollBloc.fetchAllPolls();
    _pollBloc.fetchUser(FirebaseAuth.instance.currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.charcoalGrey,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value:
              SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: AppColors.primaryColor),
          child: SafeArea(
            child: Column(
              children: [getHeaderWidget(context), getPollWidget()],
            ),
          ),
        ));
  }

  Widget getPollWidget() {
    return Expanded(
      child: StreamBuilder<List<Poll>>(
          stream: _pollBloc.getPollsListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(waterDropColor: AppColors.blueColor),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("pull up load");
                    } else if (mode == LoadStatus.loading) {
                      body = CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueColor),
                      );
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => PollItem(
                    poll: snapshot.data[index],
                    voteOnPoll: onPollItemClicked,
                    itemPosition: index,
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.blueColor,
                ),
              ),
            );
          }),
    );
  }

  Widget getHeaderWidget(BuildContext context) {
    return StreamBuilder<AppUser>(
        stream: _pollBloc.getAppUserStream,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return HomeFeedHeader(
                user: snapshot.data,
                onStartPollClicked: () {
                  startNewPoll(context);
                });
          return Container();
        });
  }

  void startNewPoll(BuildContext context) {
    Navigator.push(
      context,
      RouteAnimationSlideFromRight(
        widget: WhatsAboutPage(),
      ),
    );
  }

  void onPollItemClicked(String pollId, int choice, int pollPosition) {
    Utils.showLoader(context);
    _pollBloc.voteOnAPoll(pollId, choice, pollPosition);
  }
}

class PollItem extends StatelessWidget {
  const PollItem(
      {Key key, @required this.poll, @required this.voteOnPoll, @required this.itemPosition})
      : super(key: key);

  final Poll poll;
  final Function(String pollId, int choice, int itemPosition) voteOnPoll;
  final int itemPosition;

  @override
  Widget build(BuildContext context) {
    final totalVotes = poll.options
        .map((e) => e.numberOfVotes)
        .toList()
        .fold(0, (previousValue, element) => previousValue + element);

    List<PollVoter> pollVoters = [];

    //calculating all users
    for (int i = 0; i < poll.options.length; i++) {
      for (int j = 0; j < poll.options[i].pollVoters.length; j++) {
        pollVoters.add(poll.options[i].pollVoters[j]);
      }
    }

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
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                context.showPollVotesBottomSheet(pollVoters);
              },
              child: StackedImagesVotesAndTimeLeft(votes: totalVotes, recentPeople: pollVoters))
        ],
      ),
    );
  }

  Widget getPollPercentageIndicator() {
    int totalParticipation = 0;

    for (int i = 0; i < poll.options.length; i++) {
      totalParticipation += poll.options[i].numberOfVotes;
    }

    final maxVotedOption = poll.options
        .map((e) => e.numberOfVotes)
        .toList()
        .reduce((curr, next) => curr > next ? curr : next);

    return ListView.separated(
      itemCount: poll.options.length,
      shrinkWrap: true,
      separatorBuilder: (context, position) => const SizedBox(height: 15),
      itemBuilder: (context, position) => PollsPercentItem(
        pollOption: poll.options[position],
        ishigestVoted: poll.options[position].numberOfVotes == maxVotedOption,
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
                value: !showResults
                    ? 0
                    : pollOption.numberOfVotes != 0
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
            child: !showResults
                ? Text(pollOption?.statement, style: tsRegular1)
                : Text(
                    '${pollOption?.statement} (${(pollOption.numberOfVotes / totalPollParticipantCount * 100).floor()}%)',
                    style: ishigestVoted ? tsBoldDarkGrey : tsRegular1),
          )
        ],
      ),
    );
  }
}
