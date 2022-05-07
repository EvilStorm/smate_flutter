import 'package:flutter/material.dart';

class SectionHeader20Text extends StatelessWidget {
  final String title;
  const SectionHeader20Text({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
