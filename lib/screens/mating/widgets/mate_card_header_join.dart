import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/models/model_mate_k.dart';
import 'package:smate/screens/mating/widgets/mate_card_state_label.dart';

class MateCardHeaderJoin extends StatelessWidget {
  final MateModel mateInfo;

  Function? deleteClick;
  Function? replyClick;

  MateCardHeaderJoin({
    Key? key,
    required this.mateInfo,
    this.deleteClick,
    this.replyClick,
  }) : super(key: key);

  bool isPassedMate = false;

  bool passed() {
    if (mateInfo.mateDate!.isAfter(DateTime.now())) {
      return false;
    }
    return true;
  }

  Row actions() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            replyClick?.call();
          },
          child: SvgPicture.asset('assets/images/icon_message.svg'),
        ),
        const SizedBox(
          width: Constants.sapceGap * 2.5,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            deleteClick?.call();
          },
          icon: const Icon(
            Icons.close,
            color: ColorStore.color43,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    isPassedMate = passed();

    return Row(
      children: [
        MateCardStateLabel(isPassed: passed()),
        const Spacer(),
        actions(),
      ],
    );
  }
}
