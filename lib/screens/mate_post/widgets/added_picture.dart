import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smate/controllers/constroller_posting.dart';

class PostingAddedImage extends StatelessWidget {
  final PostingController _controller = Get.find();
  final int postion;
  PostingAddedImage({
    Key? key,
    required this.postion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.file(
                File(_controller.images[postion]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _controller.removeImage(postion),
              child: SvgPicture.asset('assets/images/icon_close_circle.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
