class TermModel {
  String? sId;
  bool? release;
  String? term;
  String? userTerm;
  int? seq;
  DateTime? createdAt;

  TermModel(
      {this.sId,
      this.release,
      this.term,
      this.userTerm,
      this.seq,
      this.createdAt});

  TermModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    release = json['release'];
    term = json['term'];
    userTerm = json['userTerm'];
    seq = json['seq'];
    createdAt = DateTime.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['release'] = release;
    data['term'] = term;
    data['userTerm'] = userTerm;
    data['seq'] = seq;
    data['createdAt'] = createdAt;
    return data;
  }
}
