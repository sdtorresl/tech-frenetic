import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> showMessage(
  BuildContext context, {
  required String title,
  required Widget content,
  List<Widget>? actions,
}) async {
  actions ??= [
    TextButton(
      child: Text(
        AppLocalizations.of(context)!.close.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .button!
            .copyWith(fontSize: 12, color: Theme.of(context).primaryColor),
      ),
      onPressed: () {
        Modular.to.pop();
      },
    ),
  ];

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title.toUpperCase()),
        content: SingleChildScrollView(child: content),
        actions: actions,
      );
    },
  );
}
