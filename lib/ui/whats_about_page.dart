import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/ui/common/heading_description_widget.dart';
import 'package:bidders/ui/common/primary_button.dart';
import 'package:bidders/utils/utils.dart';
import 'package:flutter/material.dart';

import '../routes.dart';
import 'date_time_page.dart';

class WhatsAboutPage extends StatefulWidget {
  @override
  _WhatsAboutPageState createState() => _WhatsAboutPageState();
}

class _WhatsAboutPageState extends State<WhatsAboutPage> {
  final TextEditingController _textController = TextEditingController();

  double _screenWidth, _screenHeight;

  bool hasTextEntered = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_validateText);
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.only(top: _screenWidth * 0.094),
                  padding: EdgeInsets.only(left: _screenWidth * 0.10, right: _screenWidth * 0.10),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: _screenWidth * 0.10,
                    right: _screenWidth * 0.10,
                    bottom: 50,
                    top: _screenHeight * 0.29),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const HeadingDescriptionWidget(
                      heading: 'What’s it about?',
                      description: 'Enter the leading question',
                    ),
                    SizedBox(
                      height: _screenHeight * .057,
                    ),
                    TextFormField(
                      controller: _textController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (text) => _navigateToPage(context),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        hintText: 'Start typing...',
                        filled: true,
                        contentPadding:
                            const EdgeInsets.only(left: 0, right: 10, top: 8, bottom: 20),
                        hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: AppColors.whiteOpacity60,
                            ),
                        labelStyle: Theme.of(context).textTheme.subtitle1,
                        fillColor: Colors.transparent,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.white, width: 1)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.white, width: 1)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                    left: _screenWidth * 0.10, right: _screenWidth * 0.10, top: 20, bottom: 30),
                child: AnimatedOpacity(
                  opacity: hasTextEntered ? 1.0 : 0.2,
                  duration: const Duration(milliseconds: 200),
                  child: PrimaryButton(
                      buttonText: 'Next', onButtonPressed: () => _navigateToPage(context)),
                ),
              ),
            )
          ],
        ));
  }

  void _navigateToPage(BuildContext context) {
    if (hasTextEntered) {
      Navigator.push(
        context,
        RouteAnimationSlideFromRight(
          widget: DateTimePage(),
          routeName: RouteNames.dateTime,
        ),
      );
    } else {
      Utils.showErrorMessage(context, 'Please enter text!');
    }
  }

  void _validateText() {
    if (_textController.text.toString().isNotEmpty) {
      setState(() {
        hasTextEntered = true;
      });
    } else {
      setState(() {
        hasTextEntered = false;
      });
    }
  }
}
