import 'package:flutter/material.dart';
import 'package:smate/screens/home/main_home.dart';
import 'package:smate/screens/interfere/interfere_home.dart';
import 'package:smate/screens/mating/screen_mating_home.dart';
import 'package:smate/screens/mypage/mypage_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int currentIndex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomePage(),
          InterFereHome(),
          MatingHomeScreen(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 1),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (int newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          iconSize: 24,
          // unselectedItemColor: TossColor.grey2,
          // selectedItemColor: TossColor.bluegrey,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "홈"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_photo_alternate), label: "패션의참견"),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_shipping_rounded), label: "내 모임"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: "마이페이지"),
          ],
        ),
      ),
    );
  }
}
