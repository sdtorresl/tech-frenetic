import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:techfrenetic/app/providers/categories_provider.dart';
import 'package:techfrenetic/app/widgets/highlight_container.dart';

import '../../models/categories_model.dart';
import '../../widgets/category_button.dart';

class VendorsPage extends StatefulWidget {
  final String title;
  const VendorsPage({Key? key, this.title = 'VendorsPage'}) : super(key: key);
  @override
  VendorsPageState createState() => VendorsPageState();
}

class VendorsPageState extends State<VendorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              _partners(),
              searchByCategory(),
              searchByVendor(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _partners() {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              AppLocalizations.of(context)!.vendors_title,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.expand_intro,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                suffixIcon: Icon(Icons.search,
                    color: Theme.of(context).unselectedWidgetColor),
                hintText: AppLocalizations.of(context)!.looking,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                suffixIcon: Icon(Icons.search,
                    color: Theme.of(context).unselectedWidgetColor),
                hintText: AppLocalizations.of(context)!.where_you_from,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.search,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchByCategory() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.search_by,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  ' ' + AppLocalizations.of(context)!.category,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed Pretium Felis Elit Ac varius felis suscipit sed.',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            categoriesButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget categoriesButtons() {
    CategoriesProvider _categoriesProvider = CategoriesProvider();

    return FutureBuilder(
      future: _categoriesProvider.getCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoriesModel>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> categories;
          categories = snapshot.data!
              .map((category) => CategoryButtonWidget(
                    category: category,
                    primary: false,
                  ))
              .toList();

          return Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              ...categories,
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget searchByVendor() {
    return Container(
      color: Theme.of(context).splashColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HighlightContainer(
                  child: Text(
                    AppLocalizations.of(context)!.search_by,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.vendor,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 25),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed Pretium Felis Elit Ac varius felis suscipit sed.',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () => Modular.to.pushNamed("/vendors_search"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.all_vendors + ' ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
