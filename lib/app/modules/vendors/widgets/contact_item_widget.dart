import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';

class ContactItemWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const ContactItemWidget({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: context.theme.primaryColor,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: context.textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
