import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

extension StringUtils on String {
  String? getAttributeValue(String tag, String selector) {
    Document document = parser.parse(this);
    Element? element = document.querySelector(selector);
    return element?.attributes[tag];
  }
}
