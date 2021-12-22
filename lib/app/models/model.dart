class Model {
  static dynamic returnValue(List<dynamic>? list, dynamic defaultValue) {
    if (list == null) {
      return defaultValue;
    }

    try {
      return list.isNotEmpty ? list[0]["value"]! : defaultValue;
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
