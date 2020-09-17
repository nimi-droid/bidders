import 'package:bidders/models/poll.dart';

class CreatePollRequest {
  const CreatePollRequest(
      {this.description, this.durationFromNow, this.options, this.pollImage = '', this.startTime});

  final String description;
  final DateTime durationFromNow;
  final DateTime startTime;
  final List<PollOption> options;
  final String pollImage;

  CreatePollRequest copyWith({
    String description,
    DateTime durationFromNow,
    DateTime startTime,
    List<PollOption> options,
    String pollImage,
  }) =>
      CreatePollRequest(
        description: description ?? this.description,
        durationFromNow: durationFromNow ?? this.durationFromNow,
        startTime: startTime ?? this.startTime,
        options: options ?? this.options,
        pollImage: pollImage ?? this.pollImage,
      );
}
