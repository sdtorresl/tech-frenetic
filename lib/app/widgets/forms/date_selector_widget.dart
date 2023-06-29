import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';

class DateSelectorWidget extends StatelessWidget {
  final TextEditingController dateController;
  final String? errorText;
  final void Function(DateTime? dateTime) onDateSelected;

  const DateSelectorWidget({
    super.key,
    required this.dateController,
    required this.onDateSelected,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: dateController,
      readOnly: true,
      showCursor: true,
      decoration: InputDecoration(
        label: Text(context.appLocalizations?.date ?? ''),
        suffixIcon: const Icon(Icons.date_range_outlined),
        hintText: "dd/mm/yyyy",
        hintStyle: context.textTheme.bodyText1!
            .copyWith(color: Theme.of(context).highlightColor),
        errorText: errorText,
        errorStyle:
            Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red),
      ),
      onTap: () async {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        ).then(onDateSelected);
      },
    );
  }
}
