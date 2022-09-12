import 'package:flutter/material.dart';

class ProgressButtonWidget extends StatefulWidget {
  final Widget child;
  final Future Function() onPressed;
  const ProgressButtonWidget(
      {Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  State<ProgressButtonWidget> createState() => _ProgressButtonWidgetState();
}

class _ProgressButtonWidgetState extends State<ProgressButtonWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: !_isLoading ? onPressedAction : null,
      child: Wrap(
        children: [
          _isLoading
              ? Container(
                  height: 25,
                  width: 25,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(right: 10),
                )
              : const SizedBox.shrink(),
          widget.child
        ],
      ),
    );
  }

  void onPressedAction() async {
    setState(() {
      _isLoading = true;
    });
    await widget.onPressed();
    setState(() {
      _isLoading = false;
    });
  }
}
