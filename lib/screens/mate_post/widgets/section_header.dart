import 'package:flutter/material.dart';

class SectionHeaderText extends StatelessWidget {
  final String title;
  const SectionHeaderText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
