import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MateCalendar extends StatelessWidget {
  const MateCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TableCalendar(
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            leftChevronIcon: Icon(Icons.arrow_left),
            rightChevronIcon: Icon(Icons.arrow_right),
            titleTextStyle: const TextStyle(fontSize: 16.0),
            titleCentered: true,
            formatButtonShowsNext: false,
          ),
        ),
      ),
    );
  }
}
