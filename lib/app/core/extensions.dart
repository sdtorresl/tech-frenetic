import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart' as p;

extension StringParsing on String {
  Future<PhoneNumber?> tryPhoneParse() async {
    PhoneNumber? phone;
    try {
      bool isValid =
          await p.PhoneNumberUtil.isValidPhoneNumber(this, 'US') ?? false;
      if (isValid) {
        phone = await PhoneNumber.getRegionInfoFromPhoneNumber(this);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return phone;
  }

  String parseHtmlString() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return replaceAll(exp, '');
  }

  String toCreditCard() {
    RegExp regExp = RegExp(r"[^0-9]");
    return replaceAll(regExp, '');
  }
}

extension ParseUtils on String {
  DateTime toDateTime({DateFormat? format}) {
    format ??= DateFormat('dd/mm/yyyy');
    return format.parse(this);
  }

  DateTime? toDateTimeFromRegex() {
    // Regular expression to extract the datetime in YYYY-MM-DD HH:MM:SS format
    RegExp regex = RegExp(r'(\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}:\d{2})');
    Match? match = regex.firstMatch(this);

    if (match != null) {
      String dateTimeString = match.group(1)!;
      return DateTime.parse(dateTimeString.replaceAll(' ', 'T'));
    } else {
      return null;
    }
  }
}

extension StringUtils on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension HumanDateTime on DateTime {
  String toHumanDate() {
    final currentLocale = ui.window.locale;
    final formattedLocale = Intl.canonicalizedLocale(currentLocale.toString());
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy', formattedLocale);
    return dateFormat.format(this).capitalize();
  }
}
