import 'package:flutter/material.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/models/model_brief_user.dart';

import 'package:smate/screens/mating/widgets/member_avatar.dart';

class BriefUserInfo extends StatelessWidget {
  final BriefUserModel info;
  const BriefUserInfo({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MemberAvatar(
          imageUrl: info.pictureMe,
          size: 42,
        ),
        const SizedBox(
          width: Constants.sapceGap * 3,
        ),
        Text.rich(
          TextSpan(
              text: info.nickName ?? "unkown",
              style: Theme.of(context).textTheme.headline6),
        ),
      ],
    );
  }
}
