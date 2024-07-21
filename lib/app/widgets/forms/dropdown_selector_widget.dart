import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/utils/selectable_item.dart';

class DropdownSelectorWidget<T extends SelectableItemI>
    extends StatelessWidget {
  final List<T> options;
  final T? selectedValue;
  final void Function(T? value) onChanged;
  final InputDecoration inputDecoration;
  final Key? selectorKey;

  const DropdownSelectorWidget({
    super.key,
    this.selectorKey,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.inputDecoration = const InputDecoration(),
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      key: selectorKey,
      value: selectedValue?.value,
      items: options.map((T option) {
        return DropdownMenuItem<String>(
          value: option.value,
          child: Text(
            option.toString(),
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        );
      }).toList(),
      onChanged: (value) {
        var newVal = options.firstWhere((element) => element.value == value);
        onChanged(newVal);
      },
      decoration: inputDecoration,
    );
  }
}
