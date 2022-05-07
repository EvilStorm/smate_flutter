import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/models/model_mate_k.dart';
import 'package:smate/screens/common/about_date.dart';
import 'package:smate/screens/common/button.dart';
import 'package:smate/screens/common/calendar.dart';
import 'package:smate/screens/common/section_header_20.dart';
import 'package:smate/screens/mate_post/widgets/section_header.dart';
import 'package:smate/screens/mate_post/widgets/tag_hot.dart';
import 'package:smate/screens/mate_post/widgets/widget_tag.dart';
import 'package:smate/screens/mating/widgets/member_avatar.dart';

class MateDetailScreen extends StatefulWidget {
  const MateDetailScreen({Key? key}) : super(key: key);

  @override
  State<MateDetailScreen> createState() => _MateDetailScreenState();
}

class _MateDetailScreenState extends State<MateDetailScreen> {
  late MateModel _passingModel;
  late double defaultDetailHeight;
  double detailHeight = 0;
  double dragStartPos = 0;
  double newHeight = 0;
  late double totalHeight;

  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    _passingModel = Get.arguments;

    super.initState();
  }

  int currentImageIndex = 1;
  void imageChanged(index, reason) {
    setState(() {
      currentImageIndex = index + 1;
    });
  }

  void dragStart(DragStartDetails details) {
    dragStartPos = details.localPosition.dy;
  }

  void dragUp(DragUpdateDetails details) {
    newHeight = detailHeight + (dragStartPos - details.localPosition.dy) / 15;
    if (newHeight < defaultDetailHeight) {
      logInfo(
          'newHeight < defaultDetailHeight: newHeight:$newHeight  / Default: $defaultDetailHeight');
      newHeight = detailHeight;
    }
    if (newHeight >= totalHeight) {
      logInfo('newHeight >= totalHeight: $detailHeight');
      newHeight = totalHeight;
    }

    setState(() {
      logInfo('detailHeight: $detailHeight');
      detailHeight = newHeight;
    });
  }

  Text basicInfo(String title, String info) {
    return Text.rich(
      TextSpan(
        text: title,
        style: Theme.of(context).textTheme.headline5,
        children: [
          TextSpan(text: "      "),
          TextSpan(text: info, style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    totalHeight = MediaQuery.of(context).size.height * 0.85;
    defaultDetailHeight = MediaQuery.of(context).size.height * 0.6;
    if (detailHeight == 0) {
      detailHeight = defaultDetailHeight;
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: buttonCarouselController,
              items: _passingModel.images?.map((String imageUrl) {
                return Builder(builder: (context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ),
                  );
                });
              }).toList(),
              options: CarouselOptions(
                height: 500,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: imageChanged,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin:
                          const EdgeInsets.only(right: Constants.sapceGap * 4),
                      height: 24,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Center(
                        child: Text.rich(
                          TextSpan(
                            text: '$currentImageIndex',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5),
                            children: [
                              TextSpan(
                                  text: '/${_passingModel.images?.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: ColorStore.colorAF,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Constants.sapceGap * 3,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    height: detailHeight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(Constants.sapceGap * 4,
                          0, Constants.sapceGap * 4, Constants.sapceGap * 4),
                      child: Column(
                        children: [
                          GestureDetector(
                            onVerticalDragUpdate: dragUp,
                            onVerticalDragStart: dragStart,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Constants.sapceGap * 2),
                              child: Container(
                                height: 8,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: ColorStore.color89,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Constants.sapceGap * 2),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: Constants.sapceGap * 2,
                                    ),
                                    Row(
                                      children: [
                                        MemberAvatar(
                                          userInfo: _passingModel.owner!,
                                          size: 42,
                                        ),
                                        const SizedBox(
                                          width: Constants.sapceGap * 3,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                              text: _passingModel
                                                      .owner?.nickName ??
                                                  "unkown",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: Constants.sapceGap * 6,
                                    ),
                                    SectionHeader20Text(
                                      title: _passingModel.title ?? "",
                                    ),
                                    const SizedBox(
                                      height: Constants.sapceGap * 4,
                                    ),
                                    Text(
                                      _passingModel.message ?? "",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Constants.sapceGap * 8),
                                      child: Divider(
                                        height: 1,
                                        color: ColorStore.color89,
                                      ),
                                    ),
                                    basicInfo('참가인원',
                                        '최대 ${_passingModel.memberLimit}명'),
                                    const SizedBox(
                                      height: Constants.sapceGap * 4,
                                    ),
                                    basicInfo('모임장소',
                                        _passingModel.locationStr ?? ""),
                                    const SizedBox(
                                      height: Constants.sapceGap * 4,
                                    ),
                                    basicInfo(
                                        '모임날짜',
                                        AboutDate.dateForMate_Detail.format(
                                            _passingModel.mateDate ??
                                                DateTime.now())),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Constants.sapceGap * 8),
                                      child: Divider(
                                        height: 1,
                                        color: ColorStore.color89,
                                      ),
                                    ),
                                    Text(
                                      '참여중인 메이트',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    ...?_passingModel.member?.member?.map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: Constants.sapceGap * 3),
                                        child: Row(
                                          children: [
                                            MemberAvatar(
                                              userInfo: e,
                                              size: 42,
                                            ),
                                            const SizedBox(
                                              width: Constants.sapceGap * 3,
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                  text: e.nickName ?? "unkown",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: Constants.sapceGap * 4,
                                    ),
                                    // Text(
                                    //   '참여대기 메이트',
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .bodyText1!
                                    //       .copyWith(fontWeight: FontWeight.bold),
                                    // ),
                                    // ...?_passingModel.member?.joinMember?.map(
                                    //   (e) => Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         vertical: Constants.sapceGap * 3),
                                    //     child: Row(
                                    //       children: [
                                    //         MemberAvatar(
                                    //           userInfo: e,
                                    //           size: 42,
                                    //         ),
                                    //         const SizedBox(
                                    //           width: Constants.sapceGap * 3,
                                    //         ),
                                    //         Text.rich(
                                    //           TextSpan(
                                    //               text: e.nickName ?? "unkown",
                                    //               style: Theme.of(context)
                                    //                   .textTheme
                                    //                   .headline6),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: Constants.sapceGap * 6,
                                    // ),
                                    Text(
                                      '태그',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: Constants.sapceGap * 2,
                                    ),
                                    Wrap(
                                      children: [
                                        ...?_passingModel.tags?.map(
                                          (e) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: Constants.sapceGap * 3),
                                            child: TagWidget(
                                              borderColor: ColorStore.colorD6,
                                              backgroundColor:
                                                  ColorStore.colorF6,
                                              tag: '#${e.tag}',
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: Constants.sapceGap * 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          MateButton(text: '참여하기'),
                          const SizedBox(
                            height: Constants.sapceGap * 4,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
