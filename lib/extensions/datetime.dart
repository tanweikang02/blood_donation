import 'package:intl/intl.dart';

extension Ex on DateTime {
  static DateFormat DATE_FORMAT = DateFormat("yyyy-MM-dd HH:mm");

  String toReadableFormat() => DATE_FORMAT.format(this);
}