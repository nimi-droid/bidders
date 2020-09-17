import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/common/circular_image_view.dart';
import 'package:flutter/material.dart';

enum USER_INFO_TRAILING_WIDGET { poll, bet, cross }

class UserInfoWidget extends StatelessWidget {
  final String imageUrl, heading, value;
  final USER_INFO_TRAILING_WIDGET trailing;
  final VoidCallback onTrailingBtnPressed;

  const UserInfoWidget(
      this.imageUrl, this.heading, this.value, this.trailing, this.onTrailingBtnPressed);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              CircularImageView(url: imageUrl, callBack: null),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(heading, style: tsBoldWhite14),
                  Text(value, style: tsBoldWhite12.copyWith(color: AppColors.whiteOpacity60)),
                ],
              )
            ],
          ),
        ),
        _getTrailingWidget(trailing),
      ],
    );
  }

  Widget _getTrailingWidget(USER_INFO_TRAILING_WIDGET trailing) {
    switch (trailing) {
      case USER_INFO_TRAILING_WIDGET.poll:
        return Container(
          margin: const EdgeInsets.only(top: 6),
          padding: const EdgeInsets.only(top: 3, bottom: 3, left: 13, right: 13),
          decoration: const BoxDecoration(
            color: AppColors.strongPink,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: const Text('POLL', style: tsBoldWhite10),
        );
      case USER_INFO_TRAILING_WIDGET.bet:
        return Container(
          margin: const EdgeInsets.only(top: 6),
          padding: const EdgeInsets.only(top: 3, bottom: 3, left: 13, right: 13),
          decoration: const BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: const Text('BET', style: tsBoldWhite10),
        );
      case USER_INFO_TRAILING_WIDGET.cross:
        return IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: onTrailingBtnPressed,
        );
    }
    return Container();
  }
}
