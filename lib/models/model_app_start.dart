import 'package:loggy/loggy.dart';
import 'package:smate/models/model_app_version.dart';
import 'package:smate/models/model_notify.dart';
import 'package:smate/models/model_term.dart';

class AppStartModel {
  var processState = [true, true, true];

  void setProcessStateChanged(int index, bool isPassed) {
    processState[index] = isPassed;
  }

  List<NotifyModel>? notify;
  TermModel? term;
  AppVersionModel? update;

  AppStartModel({this.notify, this.term, this.update});

  AppStartModel.fromJson(Map<String, dynamic> json) {
    if (json['notify'] != null) {
      notify = <NotifyModel>[];
      json['notify'].forEach((v) {
        notify!.add(NotifyModel.fromJson(v));
      });
    }
    term = json['term'] != null ? TermModel.fromJson(json['term']) : null;
    update = json['update'] != null
        ? AppVersionModel.fromJson(json['update'])
        : null;

    logError('update!!!!!! : ${update.toString()}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notify != null) {
      data['notify'] = notify!.map((v) => v.toJson()).toList();
    }
    if (term != null) {
      data['term'] = term!.toJson();
    }
    if (update != null) {
      data['update'] = update!.toJson();
    }
    return data;
  }
}
