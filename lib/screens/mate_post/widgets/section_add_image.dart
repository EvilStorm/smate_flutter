import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/constroller_posting.dart';
import 'package:smate/screens/mate_post/widgets/add_picture_icon.dart';
import 'package:smate/screens/mate_post/widgets/added_picture.dart';

class AddImageSection extends StatelessWidget {
  final PostingController _controller = Get.find();

  AddImageSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 100,
            alignment: Alignment.bottomCenter,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: AddPicture(
                click: _controller.addIamge,
                size: 90,
              ),
            ),
          ),
          const SizedBox(
            width: Constants.sapceGap * 3,
          ),
          Expanded(
            child: Container(
              height: 100,
              alignment: Alignment.bottomLeft,
              child: ListView.separated(
                itemBuilder: (context, index) => PostingAddedImage(
                  postion: index,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: Constants.sapceGap * 3,
                ),
                itemCount: _controller.images.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
