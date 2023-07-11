import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/vendor_model.dart';
import 'package:techfrenetic/app/widgets/category_widget.dart';

class SingleVendorWidget extends StatelessWidget {
  final VendorModel vendor;
  const SingleVendorWidget({Key? key, required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(vendor.picture),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              vendor.title,
              style: context.textTheme.headline2
                  ?.copyWith(color: context.colorScheme.primary),
            ),
          ),
          CategoryWidget(
            category: vendor.category,
            elevation: 0,
            color: context.theme.primaryColorDark,
            foregroundColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(vendor.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => Modular.to
                    .pushNamed("/vendors/${vendor.id}", arguments: vendor),
                label: const Icon(Icons.arrow_forward),
                icon: Text(context.appLocalizations?.events_learn_more ?? ''),
              ),
            ],
          )
        ],
      ),
    );
  }
}
