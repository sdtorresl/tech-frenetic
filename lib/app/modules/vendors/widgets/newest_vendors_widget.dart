import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/single_vendor_widget.dart';
import 'package:techfrenetic/app/widgets/highlighted_title_widget.dart';

import '../vendors_store.dart';

class NewestVendorsWidget extends StatelessWidget {
  final String title;
  const NewestVendorsWidget({Key? key, this.title = "NewestVendorsWidget"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorsStore _vendorsStore = Modular.get<VendorsStore>();

    return Container(
      color: context.theme.scaffoldBackgroundColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Column(
        children: [
          HighlightedTitleWidget(
              text: context.appLocalizations?.vendors_newest ?? ''),
          Observer(builder: (context) {
            switch (_vendorsStore.recentVendorsState) {
              case RecentVendorsStoreState.initial:
                return Center(
                  child: Text(context.appLocalizations?.video_load ?? ''),
                );
              case RecentVendorsStoreState.loaded:
                return Column(
                  children: _vendorsStore.recentVendors
                      .map((e) => SingleVendorWidget(vendor: e))
                      .toList(),
                );
              case RecentVendorsStoreState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return const SizedBox.shrink();
            }
          })
        ],
      ),
    );
  }
}
