import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/controller_join.dart';

class JoinProcessSectionNickName extends StatefulWidget {
  const JoinProcessSectionNickName({Key? key}) : super(key: key);

  @override
  State<JoinProcessSectionNickName> createState() =>
      _JoinProcessSectionNickNameState();
}

class _JoinProcessSectionNickNameState
    extends State<JoinProcessSectionNickName> {
  JoinController _joinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.sapceGap),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('닉네임'),
          TextField(
            controller: _joinController.nickNameController,
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () async {
              var result = await _joinController
                  .setNickName(_joinController.nickNameController.text);

              if (!result) return;

              _joinController.moveNext();
            },
            child: Text('다음'),
          ),
        ],
      ),
    );
  }
}
