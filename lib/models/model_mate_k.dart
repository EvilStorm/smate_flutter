import 'package:smate/models/model_brief_user.dart';
import 'package:smate/models/model_mate_join.dart';
import 'package:smate/models/model_tag.dart';

class MateModel {
  String? sId;
  BriefUserModel? owner;
  List<String>? images;
  String? title;
  String? message;
  int? memberLimit;
  String? locationStr;
  List<TagModel>? tags;
  bool? isShow;
  DateTime? mateDate;
  DateTime? createdAt;
  MateJoinModel? member;

  MateModel(
      {this.sId,
      this.owner,
      this.images,
      this.title,
      this.message,
      this.memberLimit,
      this.locationStr,
      this.tags,
      this.isShow,
      this.mateDate,
      this.createdAt,
      this.member});

  MateModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner = BriefUserModel.fromJson(json['owner']);
    images = json['images'].cast<String>();
    title = json['title'];
    message = json['message'];
    memberLimit = json['memberLimit'];
    locationStr = json['locationStr'];
    if (json['tags'] != null) {
      tags = <TagModel>[];
      json['tags'].forEach((v) {
        tags!.add(TagModel.fromJson(v));
      });
    }
    isShow = json['isShow'];
    mateDate = DateTime.parse(json['mateDate']);
    createdAt = DateTime.parse(json['createdAt']);
    member =
        json['member'] != null ? MateJoinModel.fromJson(json['member']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['owner'] = owner;
    data['images'] = images;
    data['title'] = title;
    data['message'] = message;
    data['memberLimit'] = memberLimit;
    data['locationStr'] = locationStr;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['isShow'] = isShow;
    data['mateDate'] = mateDate;
    data['createdAt'] = createdAt;
    if (member != null) {
      data['member'] = member!.toJson();
    }
    return data;
  }
}
