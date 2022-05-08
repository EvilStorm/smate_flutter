import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/controller_mating_detail.dart';
import 'package:smate/screens/mate_post/widgets/widget_tag.dart';

class MateAddedTags extends StatelessWidget {
  final MatingDetailController _detailController = Get.find();
  MateAddedTags({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '태그',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: Constants.sapceGap * 2,
        ),
        Wrap(
          children: [
            ...?_detailController.mateModel.value.tags?.map(
              (e) => Padding(
                padding: const EdgeInsets.only(right: Constants.sapceGap * 3),
                child: TagWidget(
                  borderColor: ColorStore.colorD6,
                  backgroundColor: ColorStore.colorF6,
                  tag: '#${e.tag}',
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
