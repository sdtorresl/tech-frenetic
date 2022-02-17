import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techfrenetic/app/models/categories_model.dart';

class CategoryButtonWidget extends StatelessWidget {
  final CategoriesModel category;
  final void Function()? onPressed;
  final bool primary;

  const CategoryButtonWidget(
      {Key? key, required this.category, this.onPressed, this.primary = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialStateProperty<Color> backgroundColor = primary
        ? MaterialStateProperty.all(Theme.of(context).primaryColor)
        : MaterialStateProperty.all(Colors.white);

    Color textColor = primary ? Colors.white : Theme.of(context).primaryColor;

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        category.category,
        style:
            Theme.of(context).textTheme.bodyText1!.copyWith(color: textColor),
      ),
      style: ButtonStyle(
        backgroundColor: backgroundColor,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Theme.of(context).indicatorColor),
          ),
        ),
      ),
    );
  }
}
