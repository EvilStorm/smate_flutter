import 'package:smate/models/model_mate_join.dart';
import 'package:smate/models/model_tag.dart';

class MateModel {
  String? sId;
  String? owner;
  List<String>? images;
  String? title;
  String? message;
  int? memberLimit;
  String? locationStr;
  List<TagModel>? tags;
  bool? isShow;
  String? mateDate;
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
    owner = json['owner'];
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
    mateDate = json['mateDate'];
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

class Tags {
  String? sId;
  int? count;
  String? tag;

  Tags({this.sId, this.count, this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['count'] = this.count;
    data['tag'] = this.tag;
    return data;
  }
}
