import 'package:flutter/material.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';

class IntroWidget extends StatelessWidget {
  final String title;
  const IntroWidget({Key? key, this.title = "IntroWidget"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      color: Colors.white,
      child: Column(
        children: [
          _imageHeader(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              context.appLocalizations?.vendors_description_long ?? '',
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  _imageHeader(BuildContext context) {
    var width = context.mediaQuery.size.width;

    return Row(
      children: [
        Column(
          children: [
            Image.asset('assets/img/vendors/vendors1.png', width: width * 0.31),
            Image.asset('assets/img/vendors/vendors3.png', width: width * 0.31),
          ],
        ),
        Expanded(
          child: Image.asset('assets/img/vendors/vendors2.png',
              width: width * 0.69),
        )
      ],
    );
  }
}
