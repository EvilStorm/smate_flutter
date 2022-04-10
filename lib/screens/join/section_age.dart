import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/controller_join.dart';

class JoinProcessSectionAge extends StatefulWidget {
  const JoinProcessSectionAge({Key? key}) : super(key: key);

  @override
  State<JoinProcessSectionAge> createState() => _JoinProcessSectionAgeState();
}

class _JoinProcessSectionAgeState extends State<JoinProcessSectionAge> {
  JoinController _joinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.sapceGap),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('나이 입력'),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              _joinController.moveNext();
            },
            child: Text('다음'),
          ),
        ],
      ),
    );
  }
}
