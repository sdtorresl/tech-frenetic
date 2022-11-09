import 'package:flutter/material.dart';

import 'mappeable.dart';

class Model extends IMappeable {
  static dynamic returnValue(dynamic value, dynamic defaultValue,
      {bool isList = false}) {
    if (value == null) {
      return defaultValue;
    }

    if (value is List<dynamic>) {
      try {
        if (value.isNotEmpty) {
          return !isList
              ? value[0]["value"]
              : value.map((e) => e["value"]).toList();
        }
        return defaultValue;
      } catch (e) {
        debugPrint(e.toString());
        debugPrint("Returning default value: " + value[0].toString());
        return defaultValue;
      }
    } else if (value is String || value is int) {
      return value;
    } else {
      return defaultValue;
    }
  }

  static dynamic returnObject(List<dynamic> list, dynamic defaultValue) {
    try {
      return list.isNotEmpty ? list[0]! : defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  IMappeable fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  @override
  IMappeable fromJson(String json) {
    throw UnimplementedError();
  }
}
