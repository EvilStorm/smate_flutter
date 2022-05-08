import 'package:flutter/material.dart';

import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';

class MyPageMenu extends StatelessWidget {
  final String title;
  final VoidCallback? onClick;
  const MyPageMenu({
    Key? key,
    required this.title,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.sapceGap * 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorStore.colorD6,
            )
          ],
        ),
      ),
    );
  }
}
