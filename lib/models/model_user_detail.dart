import 'package:smate/models/model_mate_join.dart';
import 'package:smate/models/model_mate_k.dart';
import 'package:smate/models/model_setting.dart';

class UserDetailModel {
  String? sId;
  String? email;
  String? identifyId;
  String? nickName;
  bool? gender;
  int? age;
  int? height;
  int? weight;
  int? secureLevel;
  String? pictureMe;
  String? aboutMe;
  int? step;
  int? loginType;
  bool? useStop;
  int? stopReason;
  String? pushToken;
  int? hasAward;
  SettingModel? setting;
  DateTime? createdAt;
  List<MateModel>? mate;
  List<MateJoinModel>? mateJoin;

  UserDetailModel(
      {this.sId,
      this.email,
      this.identifyId,
      this.nickName,
      this.gender,
      this.age,
      this.height,
      this.weight,
      this.secureLevel,
      this.pictureMe,
      this.aboutMe,
      this.step,
      this.loginType,
      this.useStop,
      this.stopReason,
      this.pushToken,
      this.hasAward,
      this.setting,
      this.createdAt});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    identifyId = json['identifyId'];
    nickName = json['nickName'];
    gender = json['gender'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    secureLevel = json['secureLevel'];
    pictureMe = json['pictureMe'];
    aboutMe = json['aboutMe'];
    step = json['step'];
    loginType = json['loginType'];
    useStop = json['useStop'];
    stopReason = json['stopReason'];
    pushToken = json['pushToken'];
    hasAward = json['hasAward'];
    setting =
        json['setting'] != null ? SettingModel.fromJson(json['setting']) : null;
    createdAt = DateTime.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['identifyId'] = identifyId;
    data['nickName'] = nickName;
    data['gender'] = gender;
    data['age'] = age;
    data['height'] = height;
    data['weight'] = weight;
    data['secureLevel'] = secureLevel;
    data['pictureMe'] = pictureMe;
    data['aboutMe'] = aboutMe;
    data['step'] = step;
    data['loginType'] = loginType;
    data['useStop'] = useStop;
    data['stopReason'] = stopReason;
    data['pushToken'] = pushToken;
    data['hasAward'] = hasAward;
    if (setting != null) {
      data['setting'] = setting!.toJson();
    }
    data['createdAt'] = createdAt;
    return data;
  }
}
