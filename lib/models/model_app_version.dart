class AppVersionModel {
  String? sId;
  int? appVer;
  String? say;
  bool? isMustUpdate;
  bool? isShow;
  AppVersionModel(
      {this.sId, this.appVer, this.say, this.isMustUpdate, this.isShow});

  AppVersionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appVer = json['appVer'];
    say = json['say'];
    isMustUpdate = json['isMustUpdate'];
    isShow = json['isShow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['appVer'] = appVer;
    data['say'] = say;
    data['isMustUpdate'] = isMustUpdate;
    data['isShow'] = isShow;
    return data;
  }
}
