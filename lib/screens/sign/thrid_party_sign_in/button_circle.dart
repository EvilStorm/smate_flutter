import 'package:flutter/material.dart';
import 'package:smate/contants/constants.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final VoidCallback? callback;
  const CircleButton(
      {Key? key, required this.child, this.callback, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(Constants.sapceGap / 2),
          primary: backgroundColor ?? Colors.white,
        ),
        onPressed: () {
          callback?.call();
        },
        child: child);
  }
}
