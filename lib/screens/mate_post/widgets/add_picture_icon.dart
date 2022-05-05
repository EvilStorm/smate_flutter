import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/constroller_posting.dart';

class AddPicture extends StatelessWidget {
  final PostingController _controller = Get.find();

  final Function? click;
  final double size;
  AddPicture({Key? key, this.click, this.size = 90}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click?.call();
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: ColorStore.color89),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/icon_camera.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(
              height: Constants.sapceGap * 2,
            ),
            Text.rich(TextSpan(
                text: _controller.images.length.toString(),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                children: [
                  TextSpan(
                      text: '/${_controller.maxImageCount}',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .apply(color: ColorStore.color89))
                ])),
          ],
        ),
      ),
    );
  }
}
