import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TFAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onPressed;
  final Text? title;
  final List<Widget>? widgets;
  final AppBar appBar = AppBar();

  TFAppBar({Key? key, this.onPressed, this.title, this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color foregroundColor = Theme.of(context).colorScheme.primary;
    Color backgroundColor = Colors.white;

    return AppBar(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      title: title,
      leading: IconButton(
        onPressed: onPressed ?? () => Modular.to.pop(),
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      actions: widgets,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
