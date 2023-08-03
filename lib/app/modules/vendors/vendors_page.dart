import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/categories_model.dart';
import 'package:techfrenetic/app/modules/vendors/vendors_store.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/intro_widget.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/newest_vendors_widget.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/vendors_results_widget.dart';
import 'package:techfrenetic/app/widgets/forms/dropdown_selector_widget.dart';
import 'package:techfrenetic/app/widgets/separator.dart';

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
              _searchBox(),
              const VendorsResultsWidget(),
              const IntroWidget(),
              const NewestVendorsWidget(),
              _seeMore()
            ],
          ),
        ],
      ),
    );
  }

  Widget _searchBox() {
    final VendorsStore _vendorsStore = Modular.get<VendorsStore>();

    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 30, left: 40, right: 40),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff00336a),
          Color(
            0xff0070E8,
          )
        ],
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.appLocalizations!.vendors_title,
            style: context.textTheme.headline1!.copyWith(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            context.appLocalizations!.vendors_description,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            context.appLocalizations?.vendors_name ?? '',
            style: context.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          TextFormField(
            onChanged: _vendorsStore.setName,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: context.appLocalizations!.vendors_name_hint,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            context.appLocalizations?.vendors_location ?? '',
            style: context.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: context.appLocalizations!.vendors_location_hint,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            context.appLocalizations?.vendors_area ?? '',
            style: context.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Observer(
            builder: (_) {
              switch (_vendorsStore.servicesState) {
                case ServicesStoreState.loaded:
                  return DropdownSelectorWidget<CategoriesModel>(
                    selectorKey: _vendorsStore.serviceSelectorKey,
                    options: _vendorsStore.services,
                    selectedValue: _vendorsStore.service,
                    onChanged: _vendorsStore.setService,
                    inputDecoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      hintText: context.appLocalizations!.vendors_area_hint,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: 15),
          Text(
            context.appLocalizations?.vendors_brand ?? '',
            style: context.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Observer(
            builder: (_) {
              switch (_vendorsStore.brandsState) {
                case BrandsStoreState.loaded:
                  return DropdownSelectorWidget<CategoriesModel>(
                    selectorKey: _vendorsStore.brandSelectorKey,
                    options: _vendorsStore.brands,
                    selectedValue: _vendorsStore.brand,
                    onChanged: _vendorsStore.setBrand,
                    inputDecoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      hintText: context.appLocalizations!.vendors_brand_hint,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: _vendorsStore.search,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Text(
                  context.appLocalizations!.search,
                ),
              ),
              OutlinedButton(
                onPressed: _vendorsStore.clean,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Text(
                  context.appLocalizations!.search_btn_clear,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _seeMore() {
    var width = context.mediaQuery.size.width;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
      child: Column(
        children: [
          Separator(
            separatorWidth: width * 0.8,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            context.appLocalizations?.vendors_business_invitation_title ?? '',
            style: context.textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            context.appLocalizations?.vendors_business_invitation_description ??
                '',
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () => Modular.to.pushNamed('/contact_us'),
            child: Text(
              context.appLocalizations?.contact ?? '',
              style: context.textTheme.button
                  ?.copyWith(fontSize: 16, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
