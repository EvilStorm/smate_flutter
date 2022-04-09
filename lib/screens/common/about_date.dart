import 'package:intl/intl.dart';

class AboutDate {
  static final dateFormat = DateFormat('yyyy-MM-dd');
  static final dateFormatMMdd = DateFormat('yyyy\nMM/dd');
  static final dateFormatMd = DateFormat('MM/dd');

  static final AboutDate _singleton = AboutDate._internal();

  factory AboutDate() {
    return _singleton;
  }

  AboutDate._internal();
}
