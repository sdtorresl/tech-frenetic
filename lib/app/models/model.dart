class Model {
  static dynamic returnValue(List<dynamic>? list, dynamic defaultValue,
      {bool isList = false}) {
    if (list == null) {
      return defaultValue;
    }

    try {
      if (list.isNotEmpty) {
        return !isList
            ? list[0]["value"]
            : list.map((e) => e["value"]).toList();
      }
      return defaultValue;
    } catch (e) {
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
}
