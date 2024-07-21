import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TagsWidget extends StatefulWidget {
  const TagsWidget({Key? key}) : super(key: key);

  @override
  State<TagsWidget> createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> {
  final ArticlesStore _articlesStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    TextEditingController tagsController = TextEditingController();
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: tagsController,
          decoration: InputDecoration(
              labelText: AppLocalizations.of(context)?.articles_tags ?? ''),
          onSubmitted: (String value) {
            _articlesStore.addTag(value);
            setState(() {
              tagsController.text = "";
            });
          },
        ),
        Observer(builder: (context) {
          return Wrap(
            spacing: 5,
            children: List<Widget>.generate(_articlesStore.selectedTagsLength,
                (int index) {
              return Chip(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                label: Text(
                  _articlesStore.selectedTags[index],
                  style:
                      theme.textTheme.bodyText1!.copyWith(color: Colors.white),
                ),
                deleteIcon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onDeleted: () {
                  _articlesStore.removeTag(index);
                  if (!mounted) {
                    setState(() {});
                  }
                },
                elevation: 1,
              );
            }),
          );
        }),
      ],
    );
  }
}
