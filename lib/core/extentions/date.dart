import 'package:intl/intl.dart';

extension DateTimeFormatting on String {
  String toFullDateString() {
    DateTime date = DateTime.parse(this);
    return DateFormat('EEE d, MMM yyyy HH:mm:ss').format(date);
  }
}