import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/icon_search.svg',
                    color: Colors.black,
                  ),
                ),
                hintText: '모임을 찾아보세요 :)',
                hintStyle: const TextStyle(
                  color: ColorStore.color80,
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
            ),
          ),
          const SizedBox(
            width: Constants.sapceGap * 3,
          ),
          GestureDetector(
            child: SvgPicture.asset(
              'assets/images/icon_mylocation.svg',
              width: 28,
              height: 28,
            ),
          ),
          const SizedBox(
            width: Constants.sapceGap * 3,
          ),
          GestureDetector(
            child: SvgPicture.asset(
              'assets/images/icon_notifi.svg',
              width: 28,
              height: 28,
            ),
          ),
        ],
      ),
    );
  }
}
