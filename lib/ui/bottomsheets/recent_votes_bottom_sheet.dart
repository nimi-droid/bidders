//import 'package:bidders/models/poll.dart';
//import 'package:bidders/res/app_colors.dart';
//import 'package:flutter/cupertino.dart';
//
//class RecentVotesPage extends StatelessWidget {
//  const RecentVotesPage({Key key, this.pollVoters}) : super(key: key);
//
//  final List<PollVoter> pollVoters;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        margin: const EdgeInsets.only(top: 40),
//        decoration: const BoxDecoration(
//            color: AppColors.white,
//            borderRadius:
//                BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.end,
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(top: 27, left: 20, right: 20),
//              child: Text('Voted by', style: tsBoldTextDarkGrey26, textAlign: TextAlign.start),
//            ),
//            const SizedBox(height: 15),
//            Flexible(child: likeUserStreamBuilder()),
//          ],
//        ));
//  }
//}
