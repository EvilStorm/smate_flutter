import 'package:flutter/material.dart';

import 'package:smate/contants/color_store.dart';

class TextInputBox extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int maxLength;
  final int maxLine;

  const TextInputBox({
    Key? key,
    required this.hint,
    required this.controller,
    required this.maxLength,
    required this.maxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLine,
      autocorrect: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      buildCounter: (context,
          {required currentLength, required isFocused, maxLength}) {
        return Text.rich(
          TextSpan(
            text: currentLength.toString(),
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
            children: [
              TextSpan(
                  text: '/$maxLength',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: ColorStore.color89,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ))
            ],
          ),
        );
      },
      maxLength: maxLength,
      cursorColor: Colors.black,
    );
  }
}
