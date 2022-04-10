import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/controllers/basic_controller_fn.dart';
import 'package:get/get.dart';
import 'package:smate/controllers/contoller_user_info.dart';
import 'package:smate/models/model_simple.dart';
import 'package:smate/network/http_client.dart';

class JoinController extends GetxController with BasicControllorFunctions {
  var pageIndex = 0.obs;
  var totalPage = 5;
  UserInfoController _userInfoController = Get.find();

  TextEditingController nickNameController = TextEditingController();

  void calcStartIndex() {
    if (_userInfoController.userInfo.value.nickName == null) {
      pageIndex.value = 0;
    } else if (_userInfoController.userInfo.value.gender == null) {
      pageIndex.value = 1;
    } else if (_userInfoController.userInfo.value.age == null) {
      pageIndex.value = 2;
    } else if (_userInfoController.userInfo.value.weight == null) {
      pageIndex.value = 3;
    } else {
      pageIndex.value = 0;
    }
  }

  void moveNext() {
    if (pageIndex.value == totalPage) return;

    pageIndex.value = pageIndex.value + 1;
  }

  void movePrev() {
    if (pageIndex.value == 0) return;

    pageIndex.value = pageIndex.value - 1;
  }

  Future<bool> setNickName(String nickName) async {
    bool canUse = await canUseNickName(nickName);

    if (!canUse) return false;

    var result = await setUserInfo({'nickName': nickName});
    if (result) _userInfoController.userInfo.value.nickName = nickName;
    return result;
  }

  Future<bool> setGendger(bool isFemale) async {
    var result = await setUserInfo({'gender': isFemale});
    if (result) {
      _userInfoController.userInfo.value.gender = isFemale;
    }
    return result;
  }

  Future<bool> setAge(int age) async {
    var result = await setUserInfo({'age': age});
    if (result) {
      _userInfoController.userInfo.value.age = age;
    }
    return result;
  }

  Future<bool> setHeight(int height, int weight) async {
    var result = await setUserInfo({'height': height, 'weight': weight});
    if (result) {
      _userInfoController.userInfo.value.height = height;
      _userInfoController.userInfo.value.weight = weight;
    }
    return result;
  }

  Future<bool> canUseNickName(String nickName) async {
    var response = await HttpClient.instance.get(
      '/user/check/nickName/$nickName',
    );

    if (response['code'] == 200) {
      var respModel = SimpleModel.fromJson(response['data']);
      if (respModel.result == 1) {
        return true;
      } else {
        showMessage(response['data']['message']);
        return false;
      }
    } else {
      showMessage(response['data']['message']);
      return false;
    }
  }

  Future<bool> setUserInfo(dynamic info) async {
    var response = await HttpClient.instance.patch(
      '/user',
      body: info,
    );

    if (response['code'] == 200) {
      return true;
    } else {
      showMessage(response['data']['message']);
      return false;
    }
  }
}
