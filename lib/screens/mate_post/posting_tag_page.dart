import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/constroller_posting.dart';
import 'package:smate/screens/common/search_bar.dart';
import 'package:smate/screens/mate_post/widgets/section_header.dart';
import 'package:smate/screens/mate_post/widgets/tag_hot.dart';

class TagPage extends StatelessWidget {
  TagPage({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.getTagList();

    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBar(
            hint: '모임에 주재에 맞게 테그를 추가해주세요.',
            controller: _controller.searchController,
          ),
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: Constants.sapceGap * 6,
                  ),
                  const SectionHeaderText(title: 'HOT 테그'),
                  const SizedBox(
                    height: Constants.sapceGap * 2,
                  ),
                  SizedBox(
                    height: 35,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _controller.hotTagList.length,
                      itemBuilder: (context, index) => HotTag(
                        tag: _controller.hotTagList.elementAt(index).tag ?? "",
                        onClick: _controller.addTag,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: Constants.sapceGap * 2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Constants.sapceGap * 8,
                  ),
                  const SectionHeaderText(title: '등록 테그'),
                  const SizedBox(
                    height: Constants.sapceGap * 3,
                  ),
                  Wrap(
                    children: _controller.addedTags
                        .map(
                          (element) => HotTag(
                            tag: element,
                            onClick: _controller.removeTag,
                            tagColor: Theme.of(context).primaryColor,
                          ),
                        )
                        .toList(),
                    spacing: Constants.sapceGap * 3,
                    runSpacing: Constants.sapceGap * 3,
                  ),
                ],
              ),
              Visibility(
                visible: _controller.showTagSearchResult.value,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorStore.colorF0,
                      border:
                          Border.all(color: Theme.of(context).primaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Visibility(
                                visible: !_controller.tagSearchDone.value,
                                child: Center(
                                  child: Text(
                                      "'${_controller.searchWord.value}' 검색중"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _controller.clearSearch();
                              },
                              child: SvgPicture.asset(
                                'assets/images/icon_close.svg',
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                            visible: _controller.tagIsNotFound.value,
                            child: RowSearchResult(
                              tag: _controller.searchWord.value,
                              count: 0,
                              callback: () => _controller
                                  .addTag(_controller.searchWord.value),
                            )),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => RowSearchResult(
                                    tag: _controller.searchTagList
                                            .elementAt(index)
                                            .tag ??
                                        "",
                                    count: _controller.searchTagList
                                            .elementAt(index)
                                            .count ??
                                        0,
                                    callback: () => _controller.addTag(
                                        _controller.searchTagList
                                                .elementAt(index)
                                                .tag ??
                                            ""),
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: Constants.sapceGap * 2,
                                  ),
                              itemCount: _controller.searchTagList.length),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RowSearchResult extends StatelessWidget {
  final String tag;
  final int count;
  final VoidCallback? callback;
  const RowSearchResult({
    Key? key,
    required this.tag,
    required this.count,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback?.call();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              width: Constants.sapceGap * 2,
            ),
            Text(
              '메이트 $count개',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .apply(color: ColorStore.color89),
            )
          ],
        ),
      ),
    );
  }
}
