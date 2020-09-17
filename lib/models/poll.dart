class Poll {
  DateTime createdAt;
  DateTime startTime;
  DateTime endTime;
  PollCreator user; //Could be an user object too
  String description;
  String imageUrl;
  List<PollOption> options;
  List<PollVoter> voters;

  Poll({
    this.createdAt,
    this.startTime,
    this.endTime,
    this.user,
    this.description,
    this.imageUrl,
    this.options,
    this.voters,
  });
}

class PollOption {
  String statement;
  int numberOfVotes;

  PollOption({this.statement, this.numberOfVotes});
}

class PollVoter {
  int choice;
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
