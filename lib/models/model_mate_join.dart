import 'package:smate/models/model_brief_user.dart';

class MateJoinModel {
  String? sId;
  BriefUserModel? owner;
  String? mate;
  List<BriefUserModel>? member;
  List<BriefUserModel>? joinMember;
  List<BriefUserModel>? deniedMember;
  bool? isShow;
  String? createdAt;

  MateJoinModel(
      {this.sId,
      this.owner,
      this.mate,
      this.member,
      this.joinMember,
      this.deniedMember,
      this.isShow,
      this.createdAt});

  MateJoinModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    owner =
        json['owner'] != null ? BriefUserModel.fromJson(json['owner']) : null;
    mate = json['mate'];
    if (json['member'] != null) {
      member = <BriefUserModel>[];
      json['member'].forEach((v) {
        member!.add(BriefUserModel.fromJson(v));
      });
    }
    if (json['joinMember'] != null) {
      joinMember = <BriefUserModel>[];
      json['joinMember'].forEach((v) {
        joinMember!.add(BriefUserModel.fromJson(v));
      });
    }
    if (json['deniedMember'] != null) {
      deniedMember = <BriefUserModel>[];
      json['deniedMember'].forEach((v) {
        deniedMember!.add(BriefUserModel.fromJson(v));
      });
    }
    isShow = json['isShow'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['mate'] = mate;
    if (member != null) {
      data['member'] = member!.map((v) => v.toJson()).toList();
    }
    if (joinMember != null) {
      data['joinMember'] = joinMember!.map((v) => v.toJson()).toList();
    }
    if (deniedMember != null) {
      data['deniedMember'] = deniedMember!.map((v) => v.toJson()).toList();
    }
    data['isShow'] = isShow;
    data['createdAt'] = createdAt;
    return data;
  }
}
