import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TFAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onPressed;
  final Text? title;
  final List<Widget>? actions;
  final AppBar appBar = AppBar();
  final Widget? leading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;
  final double elevation;

  TFAppBar({
    Key? key,
    this.onPressed,
    this.leading,
    this.title,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color foregroundColor = Theme.of(context).colorScheme.primary;
    Color backgroundColor = Colors.white;

    return AppBar(
      foregroundColor: this.foregroundColor ?? foregroundColor,
      backgroundColor: this.backgroundColor ?? backgroundColor,
      title: title,
      leading: leading ??
          IconButton(
            onPressed: onPressed ?? () => Modular.to.pop(),
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
      actions: actions,
      elevation: elevation,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
