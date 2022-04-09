class SettingModel {
  String? sId;
  bool? likeAlarm;
  bool? replyAlarm;
  bool? systemAlarm;
  bool? emailSend;

  SettingModel(
      {this.sId,
      this.likeAlarm,
      this.replyAlarm,
      this.systemAlarm,
      this.emailSend});

  SettingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    likeAlarm = json['likeAlarm'];
    replyAlarm = json['replyAlarm'];
    systemAlarm = json['systemAlarm'];
    emailSend = json['emailSend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['likeAlarm'] = likeAlarm;
    data['replyAlarm'] = replyAlarm;
    data['systemAlarm'] = systemAlarm;
    data['emailSend'] = emailSend;
    return data;
  }
}
