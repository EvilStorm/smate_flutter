import 'package:flutter/material.dart';

import 'package:smate/contants/constants.dart';

class TagWidget extends StatelessWidget {
  final Function? onClick;
  final String tag;
  final Color? tagColor;
  final Color? borderColor;
  final Color? backgroundColor;

  const TagWidget({
    Key? key,
    this.onClick,
    required this.tag,
    this.tagColor,
    this.borderColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick?.call(tag);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border:
              Border.all(color: borderColor ?? Theme.of(context).primaryColor),
          color: backgroundColor ?? Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.sapceGap * 3,
            vertical: Constants.sapceGap * 2,
          ),
          child: Text(
            tag,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .apply(color: tagColor ?? Colors.black),
          ),
        ),
      ),
    );
  }
}
