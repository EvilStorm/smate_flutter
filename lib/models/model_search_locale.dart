class LocaleSearchModel {
  String? sId;
  String? city;
  String? gu;
  String? dong;
  String? fullAddress;

  LocaleSearchModel({
    this.sId,
    this.city,
    this.gu,
    this.dong,
    this.fullAddress,
  });

  LocaleSearchModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    city = json['city'];
    gu = json['gu'];
    dong = json['dong'];
    fullAddress = json['fullAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['city'] = city;
    data['gu'] = gu;
    data['dong'] = dong;
    data['fullAddress'] = fullAddress;
    return data;
  }
}
