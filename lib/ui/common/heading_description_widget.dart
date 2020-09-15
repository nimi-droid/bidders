import 'package:flutter/material.dart';

class HeadingDescriptionWidget extends StatelessWidget {
  final String heading, description;

  const HeadingDescriptionWidget({
    Key key,
    this.heading,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: heading,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            text: description,
            style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 14),
          ),
        )
      ],
    );
  }
}
