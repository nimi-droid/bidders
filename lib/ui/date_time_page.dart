import 'dart:io';

import 'package:bidders/bloc/poll_bloc.dart';
import 'package:bidders/custom_views/route_animations.dart';
import 'package:bidders/models/create_poll_request.dart';
import 'package:bidders/res/app_colors.dart';
import 'package:bidders/ui/common/heading_description_widget.dart';
import 'package:bidders/ui/common/primary_button.dart';
import 'package:bidders/ui/wohoo_page.dart';
import 'package:bidders/utils/constants.dart';
import 'package:bidders/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({@required this.request});

  final CreatePollRequest request;

  @override
  _DateTimePageState createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  double _screenWidth, _screenHeight;

  bool hasDateEntered = false;

  final TextEditingController _endDateTimeController = TextEditingController();
  final TextEditingController _startDateTimeController = TextEditingController();

  DateTime selectedEndDate, selectedStartDate;
  DateTime selectedEndDateTime, selectedStartDateTime;
  TimeOfDay selectedEndTime, selectedStartTime;

  bool isStartDateTimeSelected = false;
  bool isEndDateTimeSelected = false;

  PollBloc _pollBloc;

  @override
  void initState() {
    super.initState();
    _pollBloc = PollBloc();
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
                      heading: 'When will it run?',
                      description: 'Pick a start time and end time',
                    ),
                    SizedBox(
                      height: _screenHeight * .057,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _startDateTimeController,
                            onTap: () => openDatePicker(true),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            readOnly: true,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              hintText: 'Starts',
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
                        SizedBox(width: _screenWidth * .096),
                        Expanded(
                          child: TextField(
                            controller: _endDateTimeController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            readOnly: true,
                            onTap: () => openDatePicker(false),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontWeight: FontWeight.w700),
                            decoration: InputDecoration(
                              hintText: 'Ends',
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
                        )
                      ],
                    ),
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
                  opacity: hasDateEntered ? 1.0 : 0.2,
                  duration: const Duration(milliseconds: 200),
                  child: PrimaryButton(
                      buttonText: 'Next', onButtonPressed: () => _navigateToPage(context)),
                ),
              ),
            )
          ],
        ));
  }

  void openDatePicker(bool isStartedDate) {
    if (Platform.isAndroid) {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 1))
          .then((value) => openTimePicker(value, isStartedDate));
    } else {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (context) {
          return CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (selectedDate) {
              openTimePicker(selectedDate, isStartedDate);
            },
          );
        },
      );
    }
  }

  Future openTimePicker(DateTime dateTime, bool isStartDate) async {
    if (dateTime == null) {
      return;
    }
    if (isStartDate) {
      selectedStartDate = dateTime;
    } else {
      selectedEndDate = dateTime;
    }

    if (Platform.isAndroid) {
      await showTimePicker(context: context, initialTime: TimeOfDay.now()).then((selectedTime) => {
            if (isStartDate)
              {selectedStartTime = selectedTime}
            else
              {selectedEndTime = selectedTime}
          });
    } else {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (context) {
          return CupertinoTimerPicker(
            onTimerDurationChanged: (selectedTime) {
              if (isStartDate) {
                selectedStartTime =
                    TimeOfDay(hour: selectedTime.inHours, minute: selectedTime.inMinutes);
              } else {
                selectedEndTime =
                    TimeOfDay(hour: selectedTime.inHours, minute: selectedTime.inMinutes);
              }
            },
          );
        },
      );
    }

    if (selectedStartDate != null && selectedStartTime != null && isStartDate) {
      selectedStartDateTime = DateTime(
          selectedStartDate.year,
          selectedStartDate.month,
          selectedStartDate.day,
          selectedStartTime.hour,
          selectedStartTime.minute,
          selectedStartTime.periodOffset);
      _startDateTimeController.text =
          Utils.getFormattedDate(KDateFormats.DATE_FORMAT_11, selectedStartDateTime);
      ;
    }
    if (selectedEndDate != null && selectedEndTime != null && !isStartDate) {
      selectedEndDateTime = DateTime(
          selectedEndDate.year,
          selectedEndDate.month,
          selectedEndDate.day,
          selectedEndTime.hour,
          selectedEndTime.minute,
          selectedEndTime.periodOffset);
      _endDateTimeController.text =
          Utils.getFormattedDate(KDateFormats.DATE_FORMAT_11, selectedEndDateTime);
    }
    if (selectedEndDateTime != null && selectedStartDateTime != null) {
      setState(() {
        hasDateEntered = true;
      });
    }
    return null;
  }

  void _navigateToPage(BuildContext context) {
    if (hasDateEntered) {
      Utils.showLoader(context);
      final pollTimeLeft = selectedEndDateTime.difference(DateTime.now());
      //calculating time left for the poll to end
      final durationFromNow = DateTime.now().add(pollTimeLeft);

      final createPollRequest = widget.request
          .copyWith(durationFromNow: durationFromNow, startTime: selectedStartDateTime);
      _pollBloc
          .createPoll(
              description: createPollRequest.description,
              options: createPollRequest.options,
              durationFromNow: durationFromNow,
              pollImage: createPollRequest.pollImage)
          .listen((event) {
        Utils.hideLoader();
        navigateToWohooPage(createPollRequest);
      });
    } else {
      Utils.showErrorMessage(context, 'Please select date and time!');
    }
  }

  void navigateToWohooPage(CreatePollRequest createPollRequest) {
    Navigator.pushReplacement(
      context,
      RouteAnimationSlideFromRight(
        widget: WohooPage(createPollRequest: createPollRequest),
      ),
    );
  }
}
