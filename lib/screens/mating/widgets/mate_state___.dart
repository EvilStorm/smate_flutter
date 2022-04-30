import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';

import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/contants/key_store.dart';
import 'package:smate/models/model_mate_k.dart';

class MateState extends StatelessWidget {
  final MateModel mateInfo;
  final storage = GetStorage();

  Function? menuClick;
  Function? replyClick;
  Function? deleteClick;

  MateState({
    Key? key,
    required this.mateInfo,
    this.menuClick,
    this.replyClick,
    this.deleteClick,
  }) : super(key: key);

  bool isPassedMate = false;

  bool passed() {
    if (mateInfo.mateDate!.isAfter(DateTime.now())) {
      return false;
    }
    return true;
  }

  Container stateView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isPassedMate ? const Color(0x27383838) : const Color(0x27F56E22),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Constants.sapceGap, horizontal: Constants.sapceGap * 3),
        child: Text(
          isPassedMate ? '종료' : '진행중',
          style: TextStyle(
            color: isPassedMate
                ? Theme.of(context).dialogBackgroundColor
                : Theme.of(context).primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Row actions() {
    String userId = storage.read(KeyStore.userID_I);
    if (userId == (mateInfo.owner?.sId ?? "")) {
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
              menuClick?.call();
            },
            icon: const Icon(
              Icons.more_vert,
              color: ColorStore.color43,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              replyClick?.call();
            },
            icon: const Icon(
              Icons.message,
              color: ColorStore.color43,
            ),
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
  }

  @override
  Widget build(BuildContext context) {
    isPassedMate = passed();

    return Row(
      children: [
        stateView(context),
        const Spacer(),
        actions(),
      ],
    );
  }
}
