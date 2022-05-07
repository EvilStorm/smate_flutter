import 'package:intl/intl.dart';

class AboutDate {
  static final dateFormat = DateFormat('yyyy-MM-dd');
  static final dateFormatMMdd = DateFormat('yyyy\nMM/dd');
  static final dateFormatMd = DateFormat('MM/dd');
  static final dateForMate = DateFormat('M월d일(E) a h시', 'ko');
  static final dateForMate_Detail = DateFormat('M월d일 EEE, a h:m', 'ko');
  static final dateForMate_date = DateFormat('M월d일(E)', 'ko');
  static final dateForMate_time = DateFormat('a h시 m분', 'ko');

  static final AboutDate _singleton = AboutDate._internal();

  factory AboutDate() {
    return _singleton;
  }

  AboutDate._internal();
}
