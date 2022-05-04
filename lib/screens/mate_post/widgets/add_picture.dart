import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';

class AddPicture extends StatelessWidget {
  Function? click;
  int maxCount;
  int currentCount;
  double size;
  AddPicture(
      {Key? key,
      this.click,
      this.maxCount = 0,
      this.currentCount = 0,
      this.size = 90})
      : super(key: key);

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
            Visibility(
              visible: maxCount > 0,
              child: Text(
                '$currentCount/$maxCount',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .apply(color: ColorStore.color89),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
