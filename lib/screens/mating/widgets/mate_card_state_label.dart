import 'package:flutter/material.dart';
import 'package:smate/contants/constants.dart';

class MateCardStateLabel extends StatelessWidget {
  final bool isPassed;

  const MateCardStateLabel({
    Key? key,
    required this.isPassed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isPassed ? const Color(0x27383838) : const Color(0x27F56E22),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Constants.sapceGap, horizontal: Constants.sapceGap * 3),
        child: Text(
          isPassed ? '종료' : '진행중',
          style: TextStyle(
            color: isPassed
                ? Theme.of(context).dialogBackgroundColor
                : Theme.of(context).primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
