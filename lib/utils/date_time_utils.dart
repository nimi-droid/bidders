import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatHHMMSS(int seconds) {
    final int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    final int minutes = (seconds / 60).truncate();

    final String hoursStr = (hours).toString().padLeft(2, '0');
    final String minutesStr = (minutes).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return '$minutesStr:$secondsStr';
    }

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  static String formatHHMMInUnits(int seconds) {
    final int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    final int minutes = (seconds / 60).truncate();

    final String hoursStr = (hours).toString().padLeft(1, '0');
    final String minutesStr = (minutes).toString().padLeft(2, '0');

    return '${hoursStr}h ${minutesStr}m';
  }

  static String convertStringToDateFormat(DateTime dateTime, String dateFormat) {
    return DateFormat(dateFormat).format(dateTime.toLocal());
  }
}
