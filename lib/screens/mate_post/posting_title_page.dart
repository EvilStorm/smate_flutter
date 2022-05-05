import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/constroller_posting.dart';
import 'package:smate/screens/mate_post/widgets/section_add_image.dart';
import 'package:smate/screens/mate_post/widgets/section_header.dart';
import 'package:smate/screens/mate_post/widgets/text_input.dart';

class TitlePage extends StatelessWidget {
  TitlePage({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeaderText(title: '스타일 이미지를 등록해주세요'),
        const SizedBox(
          height: Constants.sapceGap * 3,
        ),
        AddImageSection(),
        const SizedBox(
          height: Constants.sapceGap * 6,
        ),
        const SectionHeaderText(title: '모임 제목을 입력해주세요'),
        const SizedBox(
          height: Constants.sapceGap * 3,
        ),
        TextInputBox(
          hint: '제목을 입력해주세요',
          maxLength: 30,
          maxLine: 1,
          controller: _controller.titleTextController,
        ),
        const SizedBox(
          height: Constants.sapceGap * 6,
        ),
        const SectionHeaderText(title: '모임 소개글을 입력해주세요'),
        const SizedBox(
          height: Constants.sapceGap * 3,
        ),
        TextInputBox(
          hint: '소개글을 적어주세요.',
          maxLength: 600,
          maxLine: 10,
          controller: _controller.descTextController,
        ),
      ],
    );
  }
}
