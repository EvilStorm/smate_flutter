import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/contants/color_store.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/constroller_posting.dart';
import 'package:smate/models/model_search_locale.dart';
import 'package:smate/screens/common/about_date.dart';
import 'package:smate/screens/common/button.dart';
import 'package:smate/screens/common/calendar.dart';
import 'package:smate/screens/common/search_bar.dart';
import 'package:smate/screens/mate_post/widgets/section_add_image.dart';
import 'package:smate/screens/mate_post/widgets/section_header.dart';
import 'package:smate/screens/mate_post/widgets/section_member_count.dart';
import 'package:smate/screens/mate_post/widgets/text_input.dart';

class DatePage extends StatelessWidget {
  DatePage({Key? key}) : super(key: key);
  final PostingController _controller = Get.find();

  void showCalendarSelector(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext context) {
          DateTime? _selectedDate;
          return SafeArea(
            child: SizedBox(
              height: 480,
              child: Padding(
                padding: const EdgeInsets.all(Constants.sapceGap * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MateCalendar(
                      selectedDate: (date) {
                        _selectedDate = date;
                      },
                    ),
                    const Spacer(),
                    MateButton(
                      onClick: () {
                        if (_selectedDate != null) {
                          _controller.setMateDate(_selectedDate!);
                        }
                        Get.back();
                      },
                      text: '저장',
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void showTimeSelector(BuildContext context) {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext context) {
          DateTime? _selectedTime;
          return SafeArea(
            child: SizedBox(
              height: 280,
              child: Padding(
                padding: const EdgeInsets.all(Constants.sapceGap * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TimePickerSpinner(
                      is24HourMode: false,
                      minutesInterval: 5,
                      normalTextStyle: const TextStyle(
                        fontSize: 30,
                        color: ColorStore.color89,
                      ),
                      highlightedTextStyle: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                      time: _controller.selectedTime.value,
                      spacing: 30,
                      onTimeChange: (time) {
                        _selectedTime = time;
                      },
                    ),
                    const Spacer(),
                    MateButton(
                      onClick: () {
                        if (_selectedTime != null) {
                          _controller.setMateTime(_selectedTime!);
                        }
                        Get.back();
                      },
                      text: '저장',
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void showLocaleSelector(BuildContext context) {
    _controller.clearSearchLocale();

    showModalBottomSheet(
        context: context,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: 740,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.sapceGap * 4,
                    vertical: Constants.sapceGap * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: Constants.sapceGap * 3,
                    ),
                    SectionHeaderText(title: '장소찾기'),
                    const SizedBox(
                      height: Constants.sapceGap * 3,
                    ),
                    SearchBar(
                      hint: '모임 장소를 입력해주세요',
                      controller: _controller.localeController,
                    ),
                    const SizedBox(
                      height: Constants.sapceGap * 4,
                    ),
                    Obx(
                      () => Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              _controller.localeSelected.value =
                                  _controller.searchLocaleList.elementAt(index);
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Constants.sapceGap * 2),
                              child: Text(
                                _controller.searchLocaleList
                                        .elementAt(index)
                                        .fullAddress ??
                                    "",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const Divider(
                            color: ColorStore.color89,
                          ),
                          itemCount: _controller.searchLocaleList.length,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Constants.sapceGap * 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeaderText(title: '인원을 입력해주세요'),
          const SizedBox(
            height: Constants.sapceGap * 3,
          ),
          MemberCount(),
          const SizedBox(
            height: Constants.sapceGap * 6,
          ),
          const SectionHeaderText(title: '참가 나이를 설정해주세요'),
          const SizedBox(
            height: Constants.sapceGap * 2,
          ),
          GestureDetector(
            onTap: () {
              _controller.ageDontCare.value = !_controller.ageDontCare.value;
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: Theme.of(context).primaryColor,
                      value: _controller.ageDontCare.value,
                      onChanged: (checked) {
                        _controller.ageDontCare.value = checked!;
                      }),
                ),
                Text('나이 상관없음'),
              ],
            ),
          ),
          Visibility(
            visible: !_controller.ageDontCare.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Constants.sapceGap * 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Constants.sapceGap * 2),
                  child: Text(
                      '${_controller.ageRange.value.start.round()}세 ~ ${_controller.ageRange.value.end.round()}세'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: RangeSlider(
                    values: _controller.ageRange.value,
                    min: 0,
                    max: 100,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    onChanged: (range) {
                      _controller.ageRange.value = range;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Constants.sapceGap * 6,
          ),
          const SectionHeaderText(title: '날자와 시간'),
          const SizedBox(
            height: Constants.sapceGap * 3,
          ),
          GestureDetector(
            onTap: () {
              showCalendarSelector(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorStore.colorF6,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Constants.sapceGap * 2),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/icon_calendar.svg'),
                    const SizedBox(width: Constants.sapceGap * 4),
                    _controller.dateSelected.value
                        ? Text(
                            AboutDate.dateForMate_date
                                .format(_controller.selectedDate.value),
                          )
                        : Text(
                            '날짜를 선택해주세요.',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .apply(color: ColorStore.color89),
                          ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: Constants.sapceGap * 3,
          ),
          GestureDetector(
            onTap: () => showTimeSelector(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorStore.colorF6,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Constants.sapceGap * 2),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/icon_time.svg'),
                    const SizedBox(width: Constants.sapceGap * 4),
                    _controller.timeSelected.value
                        ? Text(
                            AboutDate.dateForMate_time
                                .format(_controller.selectedTime.value),
                          )
                        : Text(
                            '시간을 선택해주세요.',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .apply(color: ColorStore.color89),
                          ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: Constants.sapceGap * 6,
          ),
          const SectionHeaderText(title: '장소를 입력해주세요'),
          const SizedBox(
            height: Constants.sapceGap * 3,
          ),
          GestureDetector(
            onTap: () => showLocaleSelector(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorStore.colorF6,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Constants.sapceGap * 2),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/icon_map.svg'),
                    const SizedBox(width: Constants.sapceGap * 4),
                    _controller.localeSelected.value.fullAddress != null
                        ? Text(
                            _controller.localeSelected.value.fullAddress ?? "",
                          )
                        : Text(
                            '장소를 검색해주세요.',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .apply(color: ColorStore.color89),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
