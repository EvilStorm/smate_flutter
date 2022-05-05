import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/screens/common/search_bar.dart';

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
          const Expanded(
            child: SearchBar(
              hint: "모임을 찾아보세요 :)",
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
