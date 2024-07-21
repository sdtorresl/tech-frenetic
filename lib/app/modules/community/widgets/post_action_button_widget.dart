import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techfrenetic/app/core/extensions/context_utils.dart';

class PostActionButtonWidget extends StatelessWidget {
  final String text;
  final String iconAsset;
  final Function()? onPressed;

  const PostActionButtonWidget(
      {super.key, required this.iconAsset, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: context.theme.outlinedButtonTheme.style?.copyWith(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 25, vertical: 10)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            iconAsset,
            allowDrawingOutsideViewBox: true,
            semanticsLabel: text,
            height: 20,
            //color: context.theme.primaryColor,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: context.theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
