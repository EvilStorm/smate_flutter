class ModelSample {
  String? name;
  List<String>? images;
  int? age;

  ModelSample({this.name, this.images, this.age});

  ModelSample.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    images = json['images'].cast<String>();
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['images'] = this.images;
    data['age'] = this.age;
    return data;
  }
}
