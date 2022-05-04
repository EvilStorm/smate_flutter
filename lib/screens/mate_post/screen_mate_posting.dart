import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/constroller_posting.dart';
import 'package:smate/screens/mate_post/widgets/add_picture.dart';
import 'package:smate/screens/mate_post/widgets/posting_progress.dart';

class MatePostingScreen extends StatelessWidget {
  MatePostingScreen({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();
  final ImagePicker _picker = ImagePicker();

  void getImage() async {
    logInfo("getImage()!!!!!!!");

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _controller.images.add(image?.path);
    logError(image?.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          '스타일 모임 만들기',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Obx(
        () => Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.sapceGap * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostingProgress(),
              const SizedBox(
                height: Constants.sapceGap * 6,
              ),
              Row(
                children: [
                  Text(
                    '스타일 이미지를 등록해주세요',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              const SizedBox(
                height: Constants.sapceGap * 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AddPicture(
                    currentCount: _controller.pageIndex.value,
                    maxCount: _controller.maxPageIndex,
                    click: getImage,
                    size: 90,
                  ),
                  const SizedBox(
                    width: Constants.sapceGap * 3,
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      // color: Colors.red,
                      alignment: Alignment.bottomLeft,
                      // child: Container(
                      //   width: 90,
                      //   height: 90,
                      //   color: Colors.green,
                      // ),
                      child: ListView.separated(
                        itemBuilder: (context, index) => Stack(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.file(
                                File(_controller.images[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              right: 0,
                              child: Icon(
                                Icons.delete,
                              ),
                            ),
                          ],
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
            ],
          ),
        ),
      ),
    );
  }
}
