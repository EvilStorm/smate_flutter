import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/controllers/basic_controller_fn.dart';
import 'package:smate/models/model_mate_k.dart';
import 'package:smate/network/http_client.dart';

class MateingController extends GetxController
    with BasicControllorFunctions, GetSingleTickerProviderStateMixin {
  var tabPage = 0.obs;
  late TabController tabbarController;
  RxList<MateModel> createdMate = <MateModel>[].obs;
  RxList<MateModel> joinMate = <MateModel>[].obs;
  RxList<MateModel> likeMate = <MateModel>[].obs;

  @override
  void onInit() {
    tabbarController = TabController(length: 3, vsync: this);

    super.onInit();
    getCreatedMate();
    getJoinedMate();
    getLinkMate();
  }

  void getCreatedMate() async {
    final response = await HttpClient.instance.get("/mate/me/created/0");

    if (response['code'] == 200) {
      createdMate.value = (response['data']['created'] as List)
          .map((item) => MateModel.fromJson(item))
          .toList();
    }
  }

  void getJoinedMate() async {
    final response = await HttpClient.instance.get("/mate/me/join/0");

    if (response['code'] == 200) {
      joinMate.value = (response['data']['joined'] as List)
          .map((item) => MateModel.fromJson(item))
          .toList();
    }
  }

  void getLinkMate() async {
    final response = await HttpClient.instance.get("/mate/me/like/0");

    if (response['code'] == 200) {
      likeMate.value = (response['data']['liked'] as List)
          .map((item) => MateModel.fromJson(item))
          .toList();
    }
  }
}
