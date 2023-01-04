import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArticlesStore articlesStore = Modular.get();

    return TextField(
      maxLines: 5,
      minLines: 3,
      decoration: InputDecoration(
          labelText: AppLocalizations.of(context)?.articles_description ?? ''),
      onChanged: articlesStore.setDescription,
    );
  }
}
