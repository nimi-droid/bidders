import 'package:bidders/res/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {@required this.buttonText,
      @required this.onButtonPressed,
      this.btnColor = AppColors.blueColor});

  final String buttonText;
  final Function onButtonPressed;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: onButtonPressed,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: const BorderRadius.all(Radius.circular(27)),
        ),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(text: buttonText, style: Theme.of(context).textTheme.subtitle1),
          ),
        ),
      ),
    );
  }
}
