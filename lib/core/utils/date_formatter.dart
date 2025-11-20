import 'package:intl/intl.dart';

class DateFormatter {
  // Formats a DateTime to a readable string, e.g. "Nov 10, 2025"
  static String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  // Format with time, e.g. "Nov 10, 2025 14:30"
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM d, y.  HH:mm').format(date);
  }

}
