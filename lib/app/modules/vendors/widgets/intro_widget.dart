import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';

import '../vendors_store.dart';

class IntroWidget extends StatelessWidget {
  final String title;
  const IntroWidget({Key? key, this.title = "IntroWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VendorsStore store = Modular.get();

    return Observer(builder: (_) {
      switch (store.vendorDescriptionState) {
        case VendorDescriptionStoreState.initial:
        case VendorDescriptionStoreState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case VendorDescriptionStoreState.loaded:
          return Container(
            padding: const EdgeInsets.all(25),
            color: Colors.white,
            child: Column(
              children: [
                _imageHeader(
                  context,
                  store.description!.image1,
                  store.description!.image3,
                  store.description!.image2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    store.description?.description ?? '',
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        case VendorDescriptionStoreState.error:
          return const SizedBox.shrink();
      }
    });
  }

  _imageHeader(
      BuildContext context, String picture1, String picture2, String picture3) {
    var width = context.mediaQuery.size.width;

    return Row(
      children: [
        Column(
          children: [
            Image.network(picture1, width: width * 0.31),
            Image.network(picture2, width: width * 0.31),
          ],
        ),
        Expanded(
          child: Image.network(picture3, width: width * 0.69),
        )
      ],
    );
  }
}
