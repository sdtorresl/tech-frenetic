import 'package:flutter/material.dart';

class ActionIconWidget extends StatefulWidget {
  final IconData icon;
  final void Function()? onPressed;

  const ActionIconWidget({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  State<ActionIconWidget> createState() => _ActionIconWidgetState();
}

class _ActionIconWidgetState extends State<ActionIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool pressed = false;

  Color inactiveColor = const Color(0xff0070E8);
  Color activeColor = const Color(0xff00336A);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double scale = _animation.value;
    double opacity = _animation.value;

    return RawMaterialButton(
      onPressed: widget.onPressed != null
          ? () {
              widget.onPressed!();
              setState(() {
                pressed = !pressed;
              });
            }
          : null,
      elevation: 1.0,
      fillColor: Colors.white,
      child: SizedBox(
        height: 30,
        width: 30,
        child: Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.center,
            child: Icon(
              widget.icon,
              color: pressed ? activeColor : inactiveColor,
              size: 20,
            ),
          ),
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      shape: CircleBorder(
        side: BorderSide(
          color: pressed ? activeColor : inactiveColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
