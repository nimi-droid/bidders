class Poll {
  String id;
  DateTime createdAt;
  DateTime endTime;
  PollCreator user;
  String description;
  String imageUrl;
  List<PollOption> options;
  bool hasVoted;

  Poll({
    this.id,
    this.createdAt,
    this.endTime,
    this.user,
    this.description,
    this.imageUrl,
    this.options,
    this.hasVoted,
  });
}

class PollOption {
  String statement;
  int numberOfVotes;
  List<PollVoter> pollVoters;

  PollOption({this.statement, this.numberOfVotes, this.pollVoters});
}

class PollVoter {
  String choice;
  String userName;
  String userImage;
  String userId;

  PollVoter({this.choice, this.userId, this.userImage, this.userName});
}

class PollCreator {
  String userId;
  String userName;
  String userImage;

  PollCreator({this.userId, this.userName, this.userImage});
}
