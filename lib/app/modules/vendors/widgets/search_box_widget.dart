import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';

import '../../../models/categories_model.dart';
import '../../../widgets/forms/dropdown_selector_widget.dart';
import '../vendors_store.dart';

class SearchBoxWidget extends StatelessWidget {
  SearchBoxWidget({super.key});
  final VendorsStore _vendorsStore = Modular.get<VendorsStore>();

  @override
  Widget build(BuildContext context) {
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
          _buildNameInput(context),
          const SizedBox(height: 15),
          Text(
            context.appLocalizations?.vendors_location ?? '',
            style: context.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          _buildLocationInput(context),
          const SizedBox(height: 15),
          Text(
            context.appLocalizations?.vendors_area ?? '',
            style: context.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          _buildServicesSelector(_vendorsStore, context),
          const SizedBox(height: 15),
          Text(
            context.appLocalizations?.vendors_brand ?? '',
            style: context.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          _buildBrandsSelector(_vendorsStore, context),
          const SizedBox(height: 30),
          _buildActionButtons(_vendorsStore, context)
        ],
      ),
    );
  }

  Widget _buildNameInput(BuildContext context) {
    return TextFormField(
      controller: _vendorsStore.nameController,
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
    );
  }

  Widget _buildLocationInput(BuildContext context) {
    return TextFormField(
      controller: _vendorsStore.locationController,
      onChanged: _vendorsStore.setLocation,
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
    );
  }

  Row _buildActionButtons(VendorsStore _vendorsStore, BuildContext context) {
    return Row(
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
    );
  }

  Observer _buildBrandsSelector(
      VendorsStore _vendorsStore, BuildContext context) {
    return Observer(
      builder: (_) {
        switch (_vendorsStore.brandsState) {
          case BrandsStoreState.initial:
          case BrandsStoreState.loading:
            return TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                hintText: context.appLocalizations!.vendors_brand_hint,
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
          case BrandsStoreState.loaded:
            return DropdownSelectorWidget<CategoriesModel>(
              selectorKey: _vendorsStore.brandSelectorKey,
              options: _vendorsStore.brands,
              selectedValue: _vendorsStore.brand,
              onChanged: _vendorsStore.setBrand,
              inputDecoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
    );
  }

  Observer _buildServicesSelector(
      VendorsStore _vendorsStore, BuildContext context) {
    return Observer(
      builder: (_) {
        switch (_vendorsStore.servicesState) {
          case ServicesStoreState.initial:
          case ServicesStoreState.loading:
            return TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                hintText: context.appLocalizations!.vendors_area_hint,
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
          case ServicesStoreState.loaded:
            return DropdownSelectorWidget<CategoriesModel>(
              selectorKey: _vendorsStore.serviceSelectorKey,
              options: _vendorsStore.services,
              selectedValue: _vendorsStore.service,
              onChanged: _vendorsStore.setService,
              inputDecoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
    );
  }
}
