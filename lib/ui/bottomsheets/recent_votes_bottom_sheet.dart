import 'package:bidders/models/poll.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/dimens.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/common/circular_image_view.dart';
import 'package:flutter/material.dart';

class RecentVotesPage extends StatelessWidget {
  const RecentVotesPage({Key key, this.pollVoters}) : super(key: key);

  final List<PollVoter> pollVoters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimens.bottom_sheet_corner_radius),
        ),
        color: AppColors.charcoalGrey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RichText(
              text: const TextSpan(text: 'Voted by', style: tsBold2),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: pollVoters.length,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.margin_screen_left_right,
                vertical: Dimens.margin_screen_left_right - 10,
              ),
              itemBuilder: (context, position) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SingleVoterItem(
                    position,
                    pollVoters[position],
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class SingleVoterItem extends StatelessWidget {
  final int position;
  final PollVoter voter;

  const SingleVoterItem(this.position, this.voter);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteOpacity15,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularImageView(url: voter.userImage, callBack: null, height: 48, width: 48),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: voter.userName,
                          style: tsBoldDarkGrey.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: RichText(
                        text: TextSpan(
                          text: 'Option ${voter.choice}',
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
    );
  }
}
