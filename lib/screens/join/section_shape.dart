import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/controller_join.dart';

class JoinProcessSectionShape extends StatefulWidget {
  const JoinProcessSectionShape({Key? key}) : super(key: key);

  @override
  State<JoinProcessSectionShape> createState() =>
      _JoinProcessSectionShapeState();
}

class _JoinProcessSectionShapeState extends State<JoinProcessSectionShape> {
  JoinController _joinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.sapceGap),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('체형 입력'),
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
