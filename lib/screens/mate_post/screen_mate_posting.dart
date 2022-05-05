import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/color_store.dart';

import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/constroller_posting.dart';
import 'package:smate/screens/mate_post/posting_date_page.dart';
import 'package:smate/screens/mate_post/posting_tag_page.dart';
import 'package:smate/screens/mate_post/posting_title_page.dart';
import 'package:smate/screens/mate_post/widgets/posting_progress.dart';

class MatePostingScreen extends StatelessWidget {
  MatePostingScreen({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  List<Widget> pageList = [
    TitlePage(),
    TagPage(),
    DatePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _controller.back();
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: Text(
            '스타일 모임 만들기',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Constants.sapceGap * 5),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PostingProgress(),
                  const SizedBox(
                    height: Constants.sapceGap * 6,
                  ),
                  pageList[_controller.pageIndex.value],
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      _controller.next();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _controller.isLastPage() ? '모임 만들기' : '다음',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
