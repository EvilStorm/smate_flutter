import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loggy/loggy.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smate/contants/key_store.dart';
import 'package:smate/controllers/controller_sign.dart';
import 'package:smate/models/model_app_start.dart';
import 'package:smate/models/model_app_version.dart';

import '../network/http_client.dart';
import '../screens/common/dialog_basic.dart';
import 'basic_controller_fn.dart';

class SplashController extends GetxController
    with StateMixin<AppStartModel>, BasicControllorFunctions {
  final _storage = GetStorage();

  SplashController() {
    getAppInitData();
    // _storage.write(KeyStore.notifySeq_I, 0);
    // _storage.write(KeyStore.termSeq_I, 0);
    // _storage.write(KeyStore.appVer_I, 0);
  }

  late AppStartModel _model;

  void getAppInitData() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    final notifySeq = _storage.read(KeyStore.notifySeq_I) ?? 0;
    final termSeq = _storage.read(KeyStore.termSeq_I) ?? 0;
    var appVersion = _storage.read(KeyStore.appVer_I) ?? 0;
    if (int.parse(_packageInfo.buildNumber) > appVersion) {
      appVersion = int.parse(_packageInfo.buildNumber);
    }

    try {
      final response = await HttpClient.instance
          .get('/init/splash/$appVersion/$notifySeq/$termSeq');

      if (response['code'] == 200) {
        _model = AppStartModel.fromJson(response['data']);

        _setInitSplashProcess();
        checkProcess();
      } else {
        logInfo("Respose COde: ${response['code']}");
      }
    } catch (e) {
      logError(e);
      responseException(e);
    }
  }

  void _launchStore() {}

  void _showNessearyUpdatePop(AppVersionModel data) {
    Get.dialog(
      BasicDialog(
        title: "필수 업데이트",
        message: data.say ?? "",
        leftBtnTitle: "종료",
        leftBtnAction: () => exit(0),
        rightBtnTitle: "업데이트",
        rightBtnAction: () => _launchStore(),
        rightBtnAccent: true,
      ),
      barrierDismissible: false,
    );
  }

  void _showUpdatePop(AppVersionModel data) {
    Get.dialog(
      BasicDialog(
        message: data.say ?? "",
        leftBtnTitle: "건너뛰기",
        leftBtnAction: () {
          _model.setProcessStateChanged(0, true);

          _storage.write(KeyStore.appVer_I, data.appVer);
          Get.back();
        },
        rightBtnTitle: "업데이트",
        rightBtnAction: () => _launchStore(),
      ),
      barrierDismissible: false,
    );
  }

  void _setInitSplashProcess() {
    if (_model.update != null) {
      _model.setProcessStateChanged(0, false);
      if ((_model.update?.isMustUpdate ?? 0) == 1) {
        _showNessearyUpdatePop(_model.update!);
      } else {
        _showUpdatePop(_model.update!);
      }
    }
    if (_model.notify != null && (_model.notify?.length ?? 0) > 0) {
      _model.setProcessStateChanged(1, false);
    }
    if (_model.term != null) {
      _model.setProcessStateChanged(2, false);
    }
  }

  void _dataChange() {
    change(_model, status: RxStatus.success());
  }

  void readNotify(int seq) {
    _storage.write(KeyStore.notifySeq_I, seq);
  }

  void agreeTerm(int seq) {
    _storage.write(KeyStore.termSeq_I, seq);
  }

  void checkProcess() {
    if (_model.processState.contains(false)) {
      _dataChange();
    } else {
      final SignController _controller = Get.find();
      _controller.signInContollerStart();
    }
  }
}
