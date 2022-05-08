import 'package:flutter/material.dart';

import 'package:smate/contants/constants.dart';
import 'package:smate/screens/common/about_date.dart';

class MatingTimeSection extends StatelessWidget {
  final int maxMember;
  final String location;
  final DateTime date;

  const MatingTimeSection({
    Key? key,
    required this.maxMember,
    required this.location,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        basicInfo(context, '참가인원', '최대 $maxMember명'),
        const SizedBox(
          height: Constants.sapceGap * 4,
        ),
        basicInfo(context, '모임장소', location),
        const SizedBox(
          height: Constants.sapceGap * 4,
        ),
        basicInfo(context, '모임날짜', AboutDate.dateForMate_Detail.format(date)),
      ],
    );
  }

  Text basicInfo(BuildContext context, String title, String info) {
    return Text.rich(
      TextSpan(
        text: title,
        style: Theme.of(context).textTheme.headline5,
        children: [
          TextSpan(text: "      "),
          TextSpan(text: info, style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }
}
