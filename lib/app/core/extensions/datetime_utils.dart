import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String toDateString({String format = 'dd/MM/yyyy'}) {
    var dateFormat = DateFormat(format);
    return dateFormat.format(this);
  }
}
