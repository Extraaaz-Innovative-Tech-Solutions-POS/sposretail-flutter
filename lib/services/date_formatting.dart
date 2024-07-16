String formatDateTime(String dateTimeString) {
  try {
    DateTime dateTime = DateTime.parse(dateTimeString);
    // Custom format: yyyy-MM-dd HH:mm:ss
    return '${_addLeadingZero(dateTime.month)}-${_addLeadingZero(dateTime.day)}-${dateTime.year}';
  } catch (e) {
    return dateTimeString;
  }
}

String _addLeadingZero(int number) {
  return number.toString().padLeft(2, '0');
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  String hours = twoDigits(duration.inHours);
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));

  return '$hours:$minutes:$seconds';
}

String calculateTimeDifferenceFromString(
    String firstDateTimeString, String secondDateTimeString) {
  // Parse the date and time strings
  DateTime firstDateTime = DateTime.parse(firstDateTimeString).toUtc();
  DateTime secondDateTime = DateTime.parse(secondDateTimeString).toUtc();

  // Calculate the difference
  Duration difference = secondDateTime.difference(firstDateTime);
  String time = formatDuration(difference);
  return time;
}