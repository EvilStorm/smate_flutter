import 'package:flutter/material.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';

import 'package:smate/models/model_brief_user.dart';
import 'package:smate/screens/mating/widgets/member_avatar.dart';

class CardJoinMember extends StatelessWidget {
  final List<BriefUserModel>? userList;
  final int limitCount;
  const CardJoinMember({
    Key? key,
    this.userList,
    required this.limitCount,
  }) : super(key: key);

  Text countView() {
    return Text("/${limitCount}명 참여중");
  }

  List<Widget> userAvatars() {
    if (userList == null) {
      return [
        const SizedBox(
          width: 0,
          height: 0,
        )
      ];
    }
    return userList!
        .take(4)
        .map((e) => Padding(
              padding: const EdgeInsets.only(right: Constants.sapceGap),
              child: MemberAvatar(imageUrl: e.pictureMe),
            ))
        .toList();
  }

  String memberCount() {
    if (limitCount <= (userList?.length ?? 0)) {
      return '마감';
    } else {
      return "${userList?.length}/${limitCount}명";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ...userAvatars(),
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            memberCount(),
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: ColorStore.color43),
          ),
        ),
      ],
    );
  }
}
