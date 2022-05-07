import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/controller_main.dart';
import 'package:smate/screens/main/widgets/main_header.dart';
import 'package:smate/screens/mating/widgets/widget_mating_card.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final MainController _mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.black,
        onPressed: () {
          Get.toNamed('/mating/create');
        },
        child: SvgPicture.asset(
          'assets/images/icon_plus.svg',
          color: Colors.white,
          width: 26,
          height: 26,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.sapceGap * 5,
          vertical: Constants.sapceGap * 3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MainHeader(),
            const SizedBox(
              height: Constants.sapceGap * 8,
            ),
            Text(
              '내 주변 스타일 모임 ✨',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              height: Constants.sapceGap * 4,
            ),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: _mainController.mateList.length,
                  itemBuilder: (context, index) {
                    return MatingCard(
                      key: UniqueKey(),
                      type: MatingCardType.none,
                      height: 160,
                      mateModel: _mainController.mateList.elementAt(index),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: Constants.sapceGap * 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
