import 'package:flutter/material.dart';

class ValidateTextWidget extends StatelessWidget {
  const ValidateTextWidget({
    Key? key,
    required this.isValid,
    required this.text,
  }) : super(key: key);

  final bool isValid;
  final String text;

  @override
  Widget build(BuildContext context) {
    Color validateColor = isValid ? Colors.green : Theme.of(context).errorColor;

    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle_outline : Icons.highlight_off_outlined,
          color: validateColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: validateColor, fontSize: 15),
        ),
      ],
    );
  }
}
