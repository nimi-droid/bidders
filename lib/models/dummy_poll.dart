import 'package:flutter/material.dart';

class MyPolls {
  const MyPolls({
    @required this.question,
    @required this.optionChosen,
    @required this.odds,
    @required this.stake,
    @required this.possibleWinning,
  });

  final String question;
  final String optionChosen;
  final String odds;
  final String stake;
  final String possibleWinning;
}
