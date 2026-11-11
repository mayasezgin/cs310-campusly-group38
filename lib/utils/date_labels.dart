import 'package:flutter/material.dart';

const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// "November 12, 2026"
String longDateLabel(DateTime date) =>
    '${_months[date.month - 1]} ${date.day}, ${date.year}';

/// "Thu, Nov 12"
String shortDateLabel(DateTime date) =>
    '${_weekdays[date.weekday - 1]}, '
    '${_months[date.month - 1].substring(0, 3)} ${date.day}';

/// "4:00 PM"
String timeLabel(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}

/// "Thu, Nov 12 · 4:00 PM–6:00 PM"
String eventTimeRangeLabel(DateTime start, DateTime end) =>
    '${shortDateLabel(start)} · '
    '${timeLabel(TimeOfDay.fromDateTime(start))}–'
    '${timeLabel(TimeOfDay.fromDateTime(end))}';
