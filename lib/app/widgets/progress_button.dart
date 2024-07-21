import 'package:flutter/material.dart';

class ProgressButton extends StatefulWidget {
  const ProgressButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  final Future Function()? onPressed;
  final String text;

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed != null
          ? () async {
              setState(() {
                _isLoading = true;
              });
              await widget.onPressed!();
              setState(() {
                _isLoading = false;
              });
            }
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading
              ? Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(right: 20),
                  child: const CircularProgressIndicator(color: Colors.white),
                )
              : const SizedBox(),
          Text(
            widget.text,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
