import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

class MateCalendar extends StatefulWidget {
  final Function? selectedDate;

  const MateCalendar({
    Key? key,
    this.selectedDate,
  }) : super(key: key);

  @override
  State<MateCalendar> createState() => _MateCalendarState();
}

class _MateCalendarState extends State<MateCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(Localizations.localeOf(context).languageCode);

    return TableCalendar(
      locale: 'ko-KR',
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, date, events) => Container(
          margin: const EdgeInsets.all(4.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            date.day.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        todayBuilder: (context, date, value) => Container(
          margin: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Text(
            date.day.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        widget.selectedDate?.call(selectedDay);
        setState(() {
          _selectedDate = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        leftChevronIcon: SvgPicture.asset(
          'assets/images/icon_arrow_left.svg',
          color: Theme.of(context).primaryColor,
        ),
        rightChevronIcon: SvgPicture.asset(
          'assets/images/icon_arrow_right.svg',
          color: Theme.of(context).primaryColor,
        ),
        titleTextStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
        titleCentered: true,
      ),
    );
  }
}
