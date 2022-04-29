import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/controllers/basic_controller_fn.dart';
import 'package:smate/models/model_user_detail.dart';
import 'package:smate/network/http_client.dart';

class MateingController extends GetxController
    with BasicControllorFunctions, GetSingleTickerProviderStateMixin {
  var tabPage = 0.obs;
  late TabController tabbarController;

  @override
  void onInit() {
    tabbarController = TabController(length: 3, vsync: this);

    super.onInit();
    getMyMateInfos();
  }

  void getMyMateInfos() async {
    final response = await HttpClient.instance.get("/user/detail/me");

    var user = UserDetailModel.fromJson(response['data']);

    logInfo("user.aboutMe: ${user.aboutMe}");
    logInfo("user.mate.length: ${user.mate?.length}");
    logInfo("user.length: ${user.mateJoin?.length}");

    logInfo(response);
  }
}
