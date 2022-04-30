import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/controller_mating.dart';
import 'package:smate/screens/mating/create_mating.dart';
import 'package:smate/screens/mating/interesting_mating.dart';
import 'package:smate/screens/mating/join_matring.dart';

class MatingHomeScreen extends StatelessWidget {
  MatingHomeScreen({Key? key}) : super(key: key);

  final tabScreenWidgets = [
    CreateMating(),
    const JoinMating(),
    const InterestingMate(),
  ];

  Widget tabWidge(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        0,
        Constants.sapceGap / 2,
        0,
        Constants.sapceGap / 2,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  MateingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.sapceGap * 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     SignController controller = Get.find();
              //     controller.signOut();
              //   },
              //   child: Text('로그아웃'),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.sapceGap * 6),
                child: Text(
                  '내 모임',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                controller: _controller.tabbarController,
                indicatorPadding: const EdgeInsets.only(
                    left: Constants.sapceGap, right: Constants.sapceGap),
                tabs: [
                  tabWidge(context, '만든 모임'),
                  tabWidge(context, '참여한 모임'),
                  tabWidge(context, '관심 모임'),
                ],
              ),
              const SizedBox(
                height: Constants.sapceGap * 6,
              ),
              Expanded(
                child: TabBarView(
                  controller: _controller.tabbarController,
                  children: tabScreenWidgets,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
