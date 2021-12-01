import 'package:flutter/material.dart';

Future<void> showMessage(BuildContext context,
    {required String title,
    required Widget content,
    required List<Widget> actions}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: content),
        actions: actions,
      );
    },
  );
}
