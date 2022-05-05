import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/constroller_posting.dart';
import 'package:smate/screens/mate_post/widgets/section_add_image.dart';
import 'package:smate/screens/mate_post/widgets/section_header.dart';
import 'package:smate/screens/mate_post/widgets/text_input.dart';

class TagPage extends StatelessWidget {
  TagPage({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('TAG>>>.'),
    );
  }
}
