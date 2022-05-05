import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:smate/contants/color_store.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? doSearch;
  final String? hint;

  const SearchBar({
    Key? key,
    this.controller,
    this.doSearch,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: GestureDetector(
          onTap: () => doSearch?.call(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/images/icon_search.svg',
              color: Colors.black,
            ),
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: ColorStore.color89,
          fontSize: 16,
        ),
        filled: true,
        fillColor: ColorStore.colorF0,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorStore.colorF0),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorStore.colorF0),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
