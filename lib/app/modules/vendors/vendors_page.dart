import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/intro_widget.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/newest_vendors_widget.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/search_box_widget.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/vendors_results_widget.dart';
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
              SearchBoxWidget(),
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
