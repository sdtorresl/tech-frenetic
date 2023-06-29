abstract class SelectableItemI<T> {
  late final T value;
  late final String label;
}

class SelectableItem<T> implements SelectableItemI {
  @override
  final String label;

  @override
  final T value;

  SelectableItem({required this.label, required this.value});

  @override
  set label(String _label) {
    label = _label;
  }

  @override
  set value(_value) {
    value = _value;
  }

  @override
  String toString() {
    return label;
  }
}
