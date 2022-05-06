import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/constroller_posting.dart';
import 'package:smate/screens/mate_post/widgets/section_add_image.dart';
import 'package:smate/screens/mate_post/widgets/section_header.dart';
import 'package:smate/screens/mate_post/widgets/text_input.dart';

class DatePage extends StatelessWidget {
  DatePage({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeaderText(title: '인원을 입력해주세요'),
          const SizedBox(
            height: Constants.sapceGap * 3,
          ),
          Container(
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
                      color: _controller.isMemberMax()
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Constants.sapceGap * 6,
          ),
          const SectionHeaderText(title: '날자와 시간'),
          const SizedBox(
            height: Constants.sapceGap * 6,
          ),
          const SectionHeaderText(title: '장소를 입력해주세요'),
        ],
      ),
    );
  }
}
