import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/controller_mating.dart';
import 'package:smate/screens/mating/widgets/empty.dart';
import 'package:smate/screens/mating/widgets/widget_mating_card.dart';

class JoinMating extends StatelessWidget {
  JoinMating({Key? key}) : super(key: key);
  final MateingController _mateingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Visibility(
            visible: (_mateingController.joinMate.isEmpty == true),
            child: const EmptyView(
              title: '아직 참여한 모임이 없어요 😳',
              message: '관심있는 모임에\n참여해보세요!',
            ),
          ),
          Visibility(
            visible: (_mateingController.joinMate.isEmpty != true),
            child: ListView.separated(
              itemCount: _mateingController.joinMate.length,
              itemBuilder: (context, index) {
                return MatingCard(
                  key: UniqueKey(),
                  type: MatingCardType.join,
                  mateModel: _mateingController.joinMate.elementAt(index),
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
