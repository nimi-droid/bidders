import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/res/styles.dart';
import 'package:bidders/ui/common/heading_description_widget.dart';
import 'package:bidders/ui/common/primary_button.dart';
import 'package:bidders/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'enter_new_option_page.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> with OptionsListener {
  double _screenWidth, _screenHeight;

  List<String> optionsList = [];

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: _screenWidth * 0.10, right: _screenWidth * 0.10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: _screenWidth * 0.094),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 53),
                  const HeadingDescriptionWidget(
                    heading: 'And the options?',
                    description: 'Enter the possible choices',
                  ),
                  getOptionsListWidget(),
                  const SizedBox(height: 26),
                  getAddOptionButton()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: AnimatedOpacity(
                opacity: optionsList.length >= 2 ? 1.0 : 0.2,
                duration: const Duration(milliseconds: 200),
                child: PrimaryButton(buttonText: 'Next', onButtonPressed: moveToNextPage),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getAddOptionButton() {
    return InkWell(
      onTap: moveToAddOptionPage,
      child: DottedBorder(
        dashPattern: const [5, 8],
        strokeCap: StrokeCap.round,
        borderType: BorderType.RRect,
        color: AppColors.whiteOpacity60,
        radius: const Radius.circular(40),
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.colorTransparent,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('+', style: tsRegular1.copyWith(fontSize: 21)),
              Text(' Add Option', style: tsRegular1),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onOptionAdded(String option) {
    setState(() {
      optionsList.add(option);
    });
  }

  Widget getOptionsListWidget() {
    return Expanded(
      child: ListView.separated(
        itemCount: optionsList.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, position) => const SizedBox(height: 20),
        itemBuilder: (context, position) {
          return OptionsItem(
              optionText: optionsList[position], onCrossTapped: removeOptionItem, index: position);
        },
      ),
    );
  }

  void removeOptionItem(int index) {
    setState(() {
      optionsList.removeAt(index);
    });
  }

  void moveToAddOptionPage() {
    Navigator.of(context).push(RouteAnimationSlideFromRight(
        widget: NewOptionPage(
      listener: this,
    )));
  }

  void moveToNextPage() {
    if (optionsList.length >= 2) {
      Utils.showSuccessMessage(context, 'Coming soon');
    } else {
      Utils.showErrorMessage(context, 'Please add minimum 2 options');
    }
  }
}

mixin OptionsListener {
  void onOptionAdded(String option);
}

class OptionsItem extends StatelessWidget {
  final int index;
  final String optionText;
  final Function(int) onCrossTapped;

  const OptionsItem({Key key, this.index, this.optionText, this.onCrossTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 17, top: 17, bottom: 10, right: 23),
      decoration: BoxDecoration(
        color: AppColors.white9,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(optionText, style: tsRegular1),
          InkWell(
              onTap: () => onCrossTapped(index), child: Icon(Icons.close, color: AppColors.white))
        ],
      ),
    );
  }
}
