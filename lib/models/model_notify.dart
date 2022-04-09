class NotifyModel {
  String? sId;
  bool? appStop;
  bool? important;
  bool? show;
  String? title;
  String? say;
  int? seq;
  DateTime? createdAt;

  NotifyModel(
      {this.sId,
      this.appStop,
      this.important,
      this.show,
      this.title,
      this.say,
      this.seq,
      this.createdAt});

  NotifyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appStop = json['appStop'];
    important = json['important'];
    show = json['show'];
    title = json['title'];
    say = json['say'];
    seq = json['seq'];
    createdAt = DateTime.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['appStop'] = appStop;
    data['important'] = important;
    data['show'] = show;
    data['title'] = title;
    data['say'] = say;
    data['seq'] = seq;
    data['createdAt'] = createdAt;
    return data;
  }
}
