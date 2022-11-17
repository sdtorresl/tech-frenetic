import 'package:intl/intl.dart';
import 'package:html/parser.dart';

final DateFormat simpleDateFormatter = DateFormat('EEE dd, yyyy');

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

extension StringExtension on String {
  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

String elapsedTime(int elapsedSeconds) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  Duration duration = Duration(seconds: elapsedSeconds);
  String hours = twoDigits(duration.inHours.remainder(60));
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$hours:$minutes:$seconds";
}
