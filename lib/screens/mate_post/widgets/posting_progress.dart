import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/controllers/constroller_posting.dart';

class PostingProgress extends StatelessWidget {
  PostingProgress({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorStore.colorF0,
          ),
          width: MediaQuery.of(context).size.width,
          height: 4,
        ),
        Obx(
          () => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).primaryColor,
            ),
            width:
                (MediaQuery.of(context).size.width / _controller.maxPageIndex) *
                    (_controller.pageIndex.value + 1),
            height: 4,
          ),
        ),
      ],
    );
  }
}
