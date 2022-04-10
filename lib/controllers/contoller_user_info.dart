import 'package:get/get.dart';

import '../models/model_user.dart';

class UserInfoController extends GetxController {
  Rx<UserModel> userInfo = UserModel().obs;

  void setUserInfo(UserModel data, bool isSilent) {
    userInfo.value = data;

    if (isSilent) {
      return;
    }
    if (data.nickName == null ||
        data.age == null ||
        data.height == null ||
        data.weight == null ||
        data.gender == null) {
      Get.toNamed('/joinProcess');
    } else {
      Get.offAllNamed('/home');
    }
  }

  void setUserNickName(String nickName) {
    userInfo.value.nickName = nickName;
  }

  void setGender(bool gender) {
    userInfo.value.gender = gender;
  }

  void setHeight(int height) {
    userInfo.value.height = height;
  }

  void setWeight(int weight) {
    userInfo.value.weight = weight;
  }

  void setAge(int age) {
    userInfo.value.age = age;
  }
}
