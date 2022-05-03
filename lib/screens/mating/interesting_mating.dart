import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/controller_mating.dart';
import 'package:smate/screens/mating/widgets/empty.dart';
import 'package:smate/screens/mating/widgets/widget_mating_card.dart';

class InterestingMate extends StatelessWidget {
  InterestingMate({Key? key}) : super(key: key);

  final MateingController _mateingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Visibility(
            visible: (_mateingController.likeMate.isEmpty == true),
            child: const EmptyView(
              title: '관심이 모임이 😳',
              message: '관심 있는 모임을\n스크랩 해둬요!',
            ),
          ),
          Visibility(
            visible: (_mateingController.likeMate.isEmpty != true),
            child: ListView.separated(
              itemCount: _mateingController.likeMate.length,
              itemBuilder: (context, index) {
                return MatingCard(
                  key: UniqueKey(),
                  type: MatingCardType.like,
                  mateModel: _mateingController.likeMate.elementAt(index),
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: Constants.sapceGap * 4),
            ),
          ),
        ],
      ),
    );
  }
}
