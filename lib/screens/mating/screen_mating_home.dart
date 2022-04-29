import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/controllers/controller_mating.dart';
import 'package:smate/screens/mating/create_mating.dart';
import 'package:smate/screens/mating/interesting_mating.dart';
import 'package:smate/screens/mating/join_matring.dart';

class MatingHomeScreen extends StatelessWidget {
  MatingHomeScreen({Key? key}) : super(key: key);

  final tabWidgets = [
    const CreateMating(),
    const JoinMating(),
    const InterestingMate(),
  ];

  MateingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBar(
        controller: _controller.tabbarController,
        tabs: tabWidgets,
      ),
    );
  }
}
