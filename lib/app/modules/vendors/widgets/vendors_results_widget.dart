import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/widgets/paginator_widget.dart';

import '../vendors_store.dart';
import 'single_vendor_widget.dart';

class VendorsResultsWidget extends StatelessWidget {
  final String title;
  const VendorsResultsWidget({Key? key, this.title = "VendorsResultsWidget"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorsStore _vendorsStore = Modular.get<VendorsStore>();

    return Container(
      color: context.theme.scaffoldBackgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Observer(builder: (context) {
        switch (_vendorsStore.searchVendorsState) {
          case SearchVendorsStoreState.initial:
            return Center(
              child: Text(context.appLocalizations?.video_load ?? ''),
            );
          case SearchVendorsStoreState.loaded:
            return Column(children: [
              Text(
                  "${context.appLocalizations?.search_results}: ${_vendorsStore.vendors.length}"),
              ..._vendorsStore.vendors
                  .map((e) => SingleVendorWidget(vendor: e))
                  .toList(),
              PaginatorWidget(
                paginator: _vendorsStore.paginator,
                onPageChange: _vendorsStore.changePage,
              )
            ]);
          case SearchVendorsStoreState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
