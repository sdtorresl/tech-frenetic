import 'package:flutter/material.dart';

import 'package:techfrenetic/app/core/extensions/context_utils.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/intro_widget.dart';
import 'package:techfrenetic/app/modules/vendors/widgets/newest_vendors_widget.dart';
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
            context.appLocalizations!.expand_intro,
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
              hintText: context.appLocalizations!.looking,
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
              hintText: context.appLocalizations!.where_you_from,
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
          OutlinedButton(
            onPressed: () => null,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                context.appLocalizations!.search,
              ),
            ),
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
            onPressed: () => null,
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
