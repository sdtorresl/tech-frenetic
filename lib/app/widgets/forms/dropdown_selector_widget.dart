import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/utils/selectable_item.dart';

class DropdownSelectorWidget<T extends SelectableItemI>
    extends StatelessWidget {
  final List<T> options;
  final T? selectedValue;
  final String labelText;
  final void Function(T? value) onChanged;

  const DropdownSelectorWidget({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.labelText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      items: options.map((T option) {
        return DropdownMenuItem<T>(
          value: option,
          child: Text(
            option.toString(),
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}
