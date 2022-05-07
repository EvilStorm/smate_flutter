import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/controllers/constroller_posting.dart';

class MemberCount extends StatelessWidget {
  final PostingController _controller = Get.find();

  MemberCount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 114,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorStore.colorF6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              child: InkWell(
                splashColor: Colors.grey,
                onTap: () {
                  _controller.removeMember();
                },
                child: SvgPicture.asset(
                  'assets/images/icon_minus.svg',
                  color: _controller.memberCount.value == 1
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
            ),
            Text(_controller.memberCount.toString()),
            Material(
              child: InkWell(
                splashColor: Colors.grey,
                onTap: () {
                  _controller.addMember();
                },
                child: SvgPicture.asset(
                  'assets/images/icon_plus.svg',
                  color: _controller.isMemberMax() ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
