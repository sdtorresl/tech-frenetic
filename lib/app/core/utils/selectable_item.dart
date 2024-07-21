abstract class SelectableItemI {
  late final String? value;
  late final String label;
}

class SelectableItem implements SelectableItemI {
  @override
  final String label;

  @override
  final String? value;

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
