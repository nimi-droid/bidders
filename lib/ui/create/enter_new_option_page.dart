import 'package:bidders/res/app_colors.dart';
import 'package:bidders/ui/common/primary_button.dart';
import 'package:bidders/ui/create/options_page.dart';
import 'package:bidders/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewOptionPage extends StatefulWidget {
  const NewOptionPage({@required this.listener, Key key}) : super(key: key);

  final OptionsListener listener;

  @override
  _NewOptionPageState createState() => _NewOptionPageState();
}

class _NewOptionPageState extends State<NewOptionPage> {
  double _screenWidth, _screenHeight;

  final TextEditingController _textController = TextEditingController();
  bool hasTextEntered = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_validateText);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  margin: EdgeInsets.only(top: _screenWidth * 0.094),
                  padding: const EdgeInsets.only(left: 22, right: 25),
                  child: const Icon(
                    Icons.close,
                    size: 30,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 50, top: _screenHeight * 0.29),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _textController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (text) => sendResultAndGoBack,
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: AnimatedOpacity(
                      opacity: hasTextEntered ? 1.0 : 0.2,
                      duration: const Duration(milliseconds: 200),
                      child:
                          PrimaryButton(buttonText: 'Next', onButtonPressed: sendResultAndGoBack),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
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

  void sendResultAndGoBack() {
    if (hasTextEntered) {
      widget.listener.onOptionAdded(_textController.text);
      Navigator.of(context).pop();
    } else {
      Utils.showErrorMessage(context, 'Please enter valid option');
    }
  }
}
