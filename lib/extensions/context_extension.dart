import 'package:bidders/models/poll.dart';
import 'package:bidders/ui/bottomsheets/recent_votes_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../custom_views/custom_bottom_sheet.dart';
import '../ui/bottomsheets/bet_amount_bottom_sheet.dart';

extension ContextExtension on BuildContext {
  Future<dynamic> showBetAmountBottomSheet() {
    return showCustomModalBottomSheet(
      context: this,
      builder: (context) => BetAmountBottomSheet(),
    );
  }

  Future<dynamic> showPollVotesBottomSheet(List<PollVoter> pollVoters) {
    return showCustomModalBottomSheet(
      context: this,
      builder: (context) => RecentVotesPage(pollVoters: pollVoters),
    );
  }
}
