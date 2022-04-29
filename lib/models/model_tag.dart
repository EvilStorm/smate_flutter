class TagModel {
  String? sId;
  int? count;
  String? tag;

  TagModel({this.sId, this.count, this.tag});

  TagModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['count'] = count;
    data['tag'] = tag;
    return data;
  }
}
