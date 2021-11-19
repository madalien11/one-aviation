String dateFormatter(DateTime date, {bool hasTime = false}) {
  String result = '';
  result = '${_twoDigit(date.day)}.${_twoDigit(date.month)}.${date.year}';
  if (hasTime) {
    result += ' ${_twoDigit(date.hour)}:${_twoDigit(date.minute)}';
  }
  return result;
}

String timeFormatter(DateTime date) =>
    '${_twoDigit(date.hour)}:${_twoDigit(date.minute)}';

String timeDurationFormatter(DateTime date) =>
    '${date.hour}h ${_twoDigit(date.minute)} m';

String _twoDigit(int number) {
  String result = '';
  if (number < 9) {
    result = '0$number';
  } else {
    result = number.toString();
  }
  return result;
}
