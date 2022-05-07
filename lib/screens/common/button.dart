import 'package:flutter/material.dart';

class MateButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onClick;
  final double? height;
  final double? width;

  const MateButton({
    Key? key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.onClick,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick?.call(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height ?? 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor ?? Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18,
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5),
          ),
        ),
      ),
    );
  }
}
