import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/models/vendor_model.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/contact_item_widget.dart';
import 'package:techfrenetic/app/widgets/appbar_widget.dart';
import 'package:techfrenetic/app/widgets/category_widget.dart';
import 'package:techfrenetic/app/widgets/highlighted_title_widget.dart';

class VendorPage extends StatelessWidget {
  final VendorModel vendor;

  const VendorPage({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TFAppBar(
        onPressed: () => Modular.to.pushNamed("/vendors"),
        backgroundColor: context.theme.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(right: 30, left: 30, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(vendor.picture),
              const SizedBox(
                height: 20,
              ),
              Text(
                vendor.title,
                style: context.textTheme.headline1
                    ?.copyWith(color: context.theme.primaryColor),
              ),
              vendor.author != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(vendor.author!),
                    )
                  : const SizedBox(
                      height: 15,
                    ),
              CategoryWidget(
                category: vendor.category,
                color: context.theme.primaryColorDark,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              _vendorLocation(context),
              _vendorDescription(context),
              _contactUs(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactUs(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 15),
          child: HighlightedTitleWidget(
              text: context.appLocalizations?.contact ?? ''),
        ),
        vendor.email != null
            ? ContactItemWidget(text: vendor.email!, icon: Icons.email)
            : const SizedBox.shrink(),
        vendor.phone != null
            ? ContactItemWidget(text: vendor.phone!, icon: Icons.phone)
            : const SizedBox.shrink(),
        vendor.webpage != null
            ? ContactItemWidget(text: vendor.webpage!, icon: Icons.web)
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _vendorDescription(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              child: Text(
                vendor.description,
                style: context.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              padding: const EdgeInsets.only(left: 15),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 3,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
            Text(vendor.longDescription ?? ''),
          ],
        ),
      ),
    );
  }

  _vendorLocation(BuildContext context) {
    return vendor.location != null
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_pin,
                  color: context.theme.primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  vendor.location!,
                  style: context.textTheme.subtitle2?.copyWith(
                    color: context.theme.primaryColor,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox(
            height: 15,
          );
  }
}
