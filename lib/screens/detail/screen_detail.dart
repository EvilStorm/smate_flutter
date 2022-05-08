import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/contants/key_store.dart';
import 'package:smate/controllers/controller_mating_detail.dart';
import 'package:smate/screens/common/button.dart';
import 'package:smate/screens/common/section_header_20.dart';
import 'package:smate/screens/common/user_brief_info.dart';
import 'package:smate/screens/detail/widgets/detail_added_tags.dart';
import 'package:smate/screens/detail/widgets/detail_apply_member.dart';
import 'package:smate/screens/detail/widgets/detail_join_member.dart';
import 'package:smate/screens/detail/widgets/detail_mating_time.dart';

class MateDetailScreen extends StatefulWidget {
  const MateDetailScreen({Key? key}) : super(key: key);

  @override
  State<MateDetailScreen> createState() => _MateDetailScreenState();
}

class _MateDetailScreenState extends State<MateDetailScreen> {
  final MatingDetailController _detailController = Get.find();

  // late MateModel _passingModel;
  late double defaultDetailHeight;
  double detailHeight = 0;
  double dragStartPos = 0;
  double newHeight = 0;
  late double totalHeight;

  CarouselController buttonCarouselController = CarouselController();
  final _storage = GetStorage();
  late String myId;

  @override
  void initState() {
    // _passingModel = Get.arguments;
    // logError("_passingModel : ${Get.arguments.sId}");
    _detailController.setMate(Get.arguments);
    _detailController.getMateDetail(Get.arguments.sId!);
    myId = _storage.read(KeyStore.userID_I);

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
      newHeight = detailHeight;
    }
    if (newHeight >= totalHeight) {
      newHeight = totalHeight;
    }

    setState(() {
      detailHeight = newHeight;
    });
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
              items: _detailController.mateModel.value.images
                  ?.map((String imageUrl) {
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
                                  text:
                                      '/${_detailController.mateModel.value.images?.length}',
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
                                    BriefUserInfo(
                                        info: _detailController
                                            .mateModel.value.owner!),
                                    const SizedBox(
                                      height: Constants.sapceGap * 6,
                                    ),
                                    SectionHeader20Text(
                                      title: _detailController
                                              .mateModel.value.title ??
                                          "",
                                    ),
                                    const SizedBox(
                                      height: Constants.sapceGap * 4,
                                    ),
                                    Text(
                                      _detailController
                                              .mateModel.value.message ??
                                          "",
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
                                    MatingTimeSection(
                                        maxMember: _detailController
                                                .mateModel.value.memberLimit ??
                                            1,
                                        location: _detailController
                                                .mateModel.value.locationStr ??
                                            "",
                                        date: _detailController
                                                .mateModel.value.mateDate ??
                                            DateTime.now()),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Constants.sapceGap * 8),
                                      child: Divider(
                                        height: 1,
                                        color: ColorStore.color89,
                                      ),
                                    ),
                                    JoinMembers(
                                      isMine: isMine(),
                                    ),
                                    const SizedBox(
                                      height: Constants.sapceGap * 4,
                                    ),
                                    ApplyMembers(
                                      isMine: isMine(),
                                    ),
                                    const SizedBox(
                                      height: Constants.sapceGap * 6,
                                    ),
                                    MateAddedTags(),
                                    const SizedBox(
                                      height: Constants.sapceGap * 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Obx(() => getBottomBtns()),
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

  Widget getBottomBtns() {
    if (isMine()) {
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
    if (applyedMate()) {
      return MateButton(
        onClick: () => _detailController.joinCancelMate(),
        text: '참가 취소',
      );
    }

    return MateButton(
      onClick: () => _detailController.joinMate(),
      text: '참여하기',
    );
  }

  bool applyedMate() {
    if ((_detailController.mateModel.value.member?.member
                ?.indexWhere((element) => element.sId == myId) ??
            -1) >
        -1) {
      return true;
    }
    return false;
  }

  bool isMine() {
    if (myId == _detailController.mateModel.value.owner?.sId) {
      return true;
    }

    return false;
  }
}
