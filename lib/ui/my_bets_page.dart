import 'package:flutter/material.dart';

import '../models/dummy_bets.dart';
import '../res/app_colors.dart';

// ignore: must_be_immutable
class MyBetsPage extends StatelessWidget {
  double _screenWidth, _screenHeight;

  //dummy data
  List<MyBets> betsList = [
    const MyBets(
      question: 'Who’ll win the premier league this season?',
      optionChosen: 'Manchester City',
      odds: '1:3',
      stake: '₹ 200',
      possibleWinning: '₹ 600',
    ),
    const MyBets(
      question: 'Who’ll win the premier league this season?',
      optionChosen: 'Chelsea',
      odds: '1:3',
      stake: '₹ 100',
      possibleWinning: '₹ 300',
    ),
    const MyBets(
      question: 'Who’ll win the premier league this season?',
      optionChosen: 'Chelsea',
      odds: '1:3',
      stake: '₹ 100',
      possibleWinning: '₹ 300',
    ),
    const MyBets(
      question: 'Who’ll win the premier league this season?',
      optionChosen: 'Chelsea',
      odds: '1:3',
      stake: '₹ 100',
      possibleWinning: '₹ 300',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: _screenWidth * 0.08,
          right: _screenWidth * 0.08,
          top: _screenHeight * 0.067,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _navigateToPrevious(context),
                  child: const Icon(Icons.close, color: AppColors.white),
                ),
                RichText(
                  text: TextSpan(
                    text: 'My Bets',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                //Empty Widget
                Wrap()
              ],
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                itemCount: betsList.length,
                itemBuilder: (context, index) {
                  return _listItem(context, betsList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listItem(BuildContext context, MyBets poll) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: AppColors.whiteOpacity15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: RichText(
              text: TextSpan(text: poll.question, style: Theme.of(context).textTheme.subtitle1),
            ),
          ),
          _inCardSeparator(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 2),
            child: RichText(
              text: TextSpan(
                text: 'YOU CHOSE',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
            child: RichText(
              text: TextSpan(
                text: poll.optionChosen,
                style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          _inCardSeparator(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _stakeDetails(context, 'At', poll.odds),
                _stakeDetails(context, 'Stake', poll.stake),
                _stakeDetails(context, 'Return', poll.possibleWinning),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _inCardSeparator() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        height: 1,
        color: AppColors.charcoalGrey,
      ),
    );
  }

  Widget _stakeDetails(BuildContext context, String heading, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: heading.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        RichText(
          text: TextSpan(
            text: value,
            style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  void _navigateToPrevious(BuildContext context) {
    Navigator.pop(context);
  }
}
