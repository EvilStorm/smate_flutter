class BriefUserModel {
  String? sId;
  Null? nickName;
  Null? pictureMe;

  BriefUserModel({this.sId, this.nickName, this.pictureMe});

  BriefUserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nickName = json['nickName'];
    pictureMe = json['pictureMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['nickName'] = this.nickName;
    data['pictureMe'] = this.pictureMe;
    return data;
  }
}
