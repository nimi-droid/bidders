import 'package:flutter/material.dart';

import '../../res/styles.dart';

class AppToolbar extends StatelessWidget {
  final String title;
  final VoidCallback onTrailingBtnPressed;

  AppToolbar({@required this.title, this.onTrailingBtnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Stack(
        children: [
          Align(
            child: RichText(text: TextSpan(text: title, style: tsBold2)),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              iconSize: 18,
              onPressed: onTrailingBtnPressed,
            ),
          )
        ],
      ),
    );
  }
}
