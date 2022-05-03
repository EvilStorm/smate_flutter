import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smate/controllers/controller_home_b.dart';
import 'package:smate/screens/main_b/screen_main_b.dart';
import 'package:smate/screens/mating/screen_mating_home.dart';

class HomeScreenB extends StatelessWidget {
  HomeScreenB({Key? key}) : super(key: key);

  HomeControllerB _controllerB = Get.find();

  List<Widget> _widgetOptions = [
    MainScreenB(),
    Placeholder(),
    MatingHomeScreen(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: _widgetOptions[_controllerB.tabIndex.value],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/icon_home.svg',
                color: _controllerB.tabIndex.value == 0
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/icon_fashion.svg',
                color: _controllerB.tabIndex.value == 1
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              label: "패션의참견",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/icon_offline.svg',
                color: _controllerB.tabIndex.value == 2
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              label: "내모임",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/icon_my.svg',
                color: _controllerB.tabIndex.value == 3
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              label: "마이페이지",
            ),
          ],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) => _controllerB.tabIndex.value = index,
          currentIndex: _controllerB.tabIndex.value,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
        ),
      ),
    );
  }
}
