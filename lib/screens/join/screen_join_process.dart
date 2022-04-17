import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/controllers/controller_join.dart';
import 'package:smate/controllers/controller_sign.dart';
import 'package:smate/screens/join/section_age.dart';
import 'package:smate/screens/join/section_gender.dart';
import 'package:smate/screens/join/section_nick_name.dart';
import 'package:smate/screens/join/section_shape.dart';

class JoinProcessScreen extends StatefulWidget {
  const JoinProcessScreen({Key? key}) : super(key: key);

  @override
  State<JoinProcessScreen> createState() => _JoinProcessScreenState();
}

class _JoinProcessScreenState extends State<JoinProcessScreen> {
  JoinController _joinController = Get.find();
  SignController _controller = Get.find();
  List<Widget> pageList = [
    const JoinProcessSectionNickName(),
    const JoinProcessSectionGender(),
    const JoinProcessSectionAge(),
    const JoinProcessSectionShape(),
  ];

  @override
  void initState() {
    _joinController.calcStartIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _joinController.calcStartIndex();
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Text(
                  'Page: ${_joinController.pageIndex.value}/${_joinController.totalPage}'),
              Expanded(
                child: IndexedStack(
                  index: _joinController.pageIndex.value,
                  children: pageList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
