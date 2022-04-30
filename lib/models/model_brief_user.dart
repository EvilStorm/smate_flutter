class BriefUserModel {
  String? sId;
  String? nickName;
  String? pictureMe;

  BriefUserModel({sId, this.nickName, this.pictureMe});

  BriefUserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nickName = json['nickName'];
    pictureMe = json['pictureMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['nickName'] = nickName;
    data['pictureMe'] = pictureMe;
    return data;
  }
}
