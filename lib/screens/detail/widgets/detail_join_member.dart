import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:smate/contants/constants.dart';
import 'package:smate/contants/key_store.dart';
import 'package:smate/controllers/controller_mating_detail.dart';
import 'package:smate/screens/common/button.dart';
import 'package:smate/screens/mating/widgets/member_avatar.dart';

class JoinMembers extends StatelessWidget {
  final MatingDetailController _controller = Get.find();
  final bool isMine;
  final storage = GetStorage();
  late String myId;
  JoinMembers({
    Key? key,
    required this.isMine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myId = storage.read(KeyStore.userID_I);
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '참여중인 메이트',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          ...?_controller.mateModel.value.member?.joinMember?.map(
            (e) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Constants.sapceGap * 3),
              child: Row(
                children: [
                  MemberAvatar(
                    imageUrl: e.pictureMe,
                    size: 42,
                  ),
                  const SizedBox(
                    width: Constants.sapceGap * 3,
                  ),
                  Text.rich(
                    TextSpan(
                        text: e.nickName ?? "unkown",
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: isMine,
                    child: Row(
                      children: [
                        Visibility(
                          visible: myId != e.sId,
                          child: MateButton(
                            onClick: () {
                              _controller.acceptCancel(e.sId!);
                            },
                            text: '제외',
                            width: 70,
                            height: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
