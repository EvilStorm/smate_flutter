import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/controllers/controller_mating.dart';
import 'package:smate/screens/mating/widgets/widget_mating_card.dart';
import 'package:smate/screens/mating/widgets/empty.dart';

class CreateMating extends StatelessWidget {
  CreateMating({Key? key}) : super(key: key);

  final MateingController _mateingController = Get.find();

  void createMate() {
    logInfo(' Create Mate');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Visibility(
            visible:
                (_mateingController.userDetail.value.mate?.isEmpty ?? true),
            child: EmptyView(
              title: '내가 만든 모임이 없어요 😳',
              message: '나와 같이 할 사람을 모을\n모임을 만들러 갈까요?',
              btnText: '모임 만들기',
              onClick: createMate,
            ),
          ),
          Visibility(
            visible:
                !(_mateingController.userDetail.value.mate?.isEmpty ?? true),
            child: ListView.builder(
                itemCount:
                    _mateingController.userDetail.value.mate?.length ?? 0,
                itemBuilder: (context, index) {
                  logInfo(
                      ' INEX : $index  SIze${_mateingController.userDetail.value.mate?.length} ');
                  return MatingCard(
                    key: UniqueKey(),
                    type: MatingCardType.mine,
                    mateModel: _mateingController.userDetail.value.mate!
                        .elementAt(index),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
