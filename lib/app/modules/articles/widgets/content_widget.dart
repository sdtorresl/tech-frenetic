import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContentWidget extends StatelessWidget {
  ContentWidget({Key? key}) : super(key: key);

  final ArticlesStore articlesStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 20,
      minLines: 5,
      decoration: InputDecoration(
          labelText: AppLocalizations.of(context)?.articles_content ?? ''),
      onChanged: articlesStore.setContent,
    );
  }
}
