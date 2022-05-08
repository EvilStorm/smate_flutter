import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smate/controllers/controller_home.dart';
import 'package:smate/screens/main/screen_main.dart';
import 'package:smate/screens/mating/screen_mating_home.dart';
import 'package:smate/screens/mypage/screen_my_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController _controller = Get.find();

  final List<Widget> _widgetOptions = [
    MainScreen(),
    MatingHomeScreen(),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: _widgetOptions[_controller.tabIndex.value],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/icon_home.svg',
                color: _controller.tabIndex.value == 0
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              label: "홈",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/icon_offline.svg',
                color: _controller.tabIndex.value == 1
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              label: "내모임",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/icon_my.svg',
                color: _controller.tabIndex.value == 2
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              label: "마이페이지",
            ),
          ],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) => _controller.tabIndex.value = index,
          currentIndex: _controller.tabIndex.value,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.black,
        ),
      ),
    );
  }
}
