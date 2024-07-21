import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/modules/articles/articles_store.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({Key? key}) : super(key: key);

  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  final ArticlesStore articlesStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoriesProvider.getCategories(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<CategoriesModel> categories = snapshot.data;

          articlesStore.category =
              articlesStore.category ?? categories.first.id;
          return DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)?.articles_categories ?? '',
              ),
              value: articlesStore.category,
              isExpanded: true,
              items: categories
                  .map((CategoriesModel valueItem) => DropdownMenuItem<String>(
                        child: Text(valueItem.category),
                        value: valueItem.id,
                      ))
                  .toList(),
              onChanged: articlesStore.setCategory);
        } else {
          return Text(
            'Loading categories...',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }
}
