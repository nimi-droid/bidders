import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class CreatePollBloc extends BaseBloc {
  final _getPollOptionsSuccessBS = BehaviorSubject<List<String>>();

  Stream<List<String>> get getPollsListStream => _getPollOptionsSuccessBS.stream;

  List<String> pollOptions = [];

  @override
  void onDispose() {
    _getPollOptionsSuccessBS.close();
    super.onDispose();
  }

  void addOption(String option) {
    if (option != null) {
      pollOptions.add(option);
      _getPollOptionsSuccessBS.add(pollOptions);
    }
  }

  void removeOption(int position) {
    //check if it is within range
    if (position <= pollOptions.length - 1) {
      pollOptions.removeAt(position);
      _getPollOptionsSuccessBS.add(pollOptions);
    }
  }
}
