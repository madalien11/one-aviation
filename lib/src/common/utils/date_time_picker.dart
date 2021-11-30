import 'package:flutter/material.dart';

Future<String> dateTimePicker(
  BuildContext context,
  String departure, {
  bool isDeparture = true,
  bool isSearch = true,
}) async {
  String _result = '';
  final initialDate = isDeparture
      ? DateTime.now()
      : departure != 'Departure'
          ? DateTime.parse(departure).add(
              Duration(days: 1),
            )
          : DateTime.now().add(
              Duration(days: 1),
            );

  final date = await showDatePicker(
    context: context,
    firstDate: isDeparture
        ? DateTime.now()
        : departure != 'Departure'
            ? DateTime.parse(departure).add(
                Duration(days: 1),
              )
            : DateTime.now().add(Duration(days: 1)),
    lastDate: isDeparture
        ? DateTime.now().add(Duration(days: 120))
        : departure != 'Departure'
            ? DateTime.parse(departure).add(Duration(days: 121))
            : DateTime.now().add(Duration(days: 121)),
    initialDate: initialDate,
  );
  if (date != null) {
    if (!isSearch) {
      final initialTime = TimeOfDay.now();
      final time = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (time != null) {
        isDeparture
            ? _result = date
                    .add(Duration(hours: time.hour, minutes: time.minute))
                    .toIso8601String() +
                'Z'
            : _result = date
                    .add(Duration(hours: time.hour, minutes: time.minute))
                    .toIso8601String() +
                'Z';
      }
    } else {
      isDeparture
          ? _result = date.toIso8601String() + 'Z'
          : _result = date.toIso8601String() + 'Z';
    }
  } else {
    _result = isDeparture ? 'Departure' : 'Return';
  }

  return _result;
}
