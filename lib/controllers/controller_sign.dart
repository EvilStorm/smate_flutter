import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/contants/key_store.dart';
import 'package:smate/screens/common/dialog_basic.dart';

import '../models/model_user.dart';
import '../network/http_client.dart';
import 'contoller_user_info.dart';

class SignController extends GetxController {
  Rx<int> remindTime = 0.obs;

  var emailVerification = false.obs;
  var enabledVerifyEmail = true.obs;

  // 5분 간격으로 인증 메일 요청가능
  final int _emailValidationWaitTime = 60 * 5;
  Timer? _timer;

  final storage = GetStorage();

  void signInContollerStart() {
    FirebaseAuth.instance.userChanges().listen((user) async {
      logDebug("userChanges : $user");

      if (user == null) {
        _stopAuthReloadDemon();
        Get.offAllNamed('/signIn');
        return;
      }

      //이메일 인증은 일단 하지 않는다.
      // if (!_passedEmailVerifyCheck(user)) {
      //   if (Get.currentRoute == '/emailValidation') return;
      //   Log.i('Firebase Auth move EmailValidation Screen');
      //   Get.offAllNamed('/emailValidation');
      // } else {
      _stopAuthReloadDemon();
      signInMyApp();
      // }
    });
  }

  void signInMyApp() async {
    try {
      final signIn = await HttpClient.instance.post('/sign/signin', body: {
        'identifyId': FirebaseAuth.instance.currentUser?.uid,
        'email': FirebaseAuth.instance.currentUser?.providerData[0].email,
        'loginType': signInType().toString(),
      });

      if (signIn['code'] == 200) {
        var user = UserModel.fromJson(signIn['data']);
        UserInfoController userInfo = Get.find<UserInfoController>();
        userInfo.setUserInfo(user, false);

        storage.write(KeyStore.userID_I, user.sId);
        HttpClient.instance.addHeader('identifyid', user.identifyId);
        HttpClient.instance.addHeader('userid', user.sId.toString());
      } else {
        Fluttertoast.showToast(msg: '로그인에 실패했습니다.');
        signOut();
      }
    } catch (e) {
      logError(e);
      Get.dialog(
        BasicDialog(
          message: '앱 이용이 불가능합니다.\n잠시 후 다시 시도해주세요.',
          rightBtnAction: () => exit(0),
          rightBtnTitle: "종료",
        ),
        barrierDismissible: false,
      );
    }
  }

  bool _passedEmailVerifyCheck(user) {
    //KAKAO 로그인은 providerData와 ProviderId가 존재하지 않는다.
    //uid 로 구분
    if (user.uid.startsWith('kakao')) {
      storage.write(KeyStore.signInType_S, 'kakao');

      return true;
    }

    storage.write(KeyStore.signInType_S, user.providerData[0].providerId);
    //ThridParty auth를 이용하면 이메일 인증은 false로 들어온다.
    //password를 사용하고, email인증이 되지 않으면 이메일 인증 화면으로 보낸다.
    if (user.providerData[0].providerId == 'password' && !user.emailVerified) {
      return false;
    }
    return true;
  }

  void sendEmailVdalition() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    _startAuthReloadDemon();
  }

  void _stopAuthReloadDemon() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void _startAuthReloadDemon() {
    if (_timer != null && _timer!.isActive) return;

    remindTime.value = _emailValidationWaitTime;
    enabledVerifyEmail.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remindTime.value == 0) {
        enabledVerifyEmail.value = true;
        timer.cancel();
        return;
      }

      if (remindTime % 5 == 0) {
        logInfo('FireBase reload');
        FirebaseAuth.instance.currentUser?.reload();
      }
      remindTime.value--;
    });
  }

  void signIn() {
    signInMyApp();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    HttpClient.instance.clearHeader();

    storage.erase();

    var signType = storage.read(KeyStore.signInType_S);
    switch (signType) {
      case 'kakao':
        await UserApi.instance.logout();
        break;
      case 'google.com':
        await GoogleSignIn().signOut();
        break;
      case 'facebook.com':
        await FacebookAuth.instance.logOut();
        break;
    }
    UserInfoController _controller = Get.find();
    _controller.setUserInfo(UserModel(), true);
  }

  int signInType() {
    var signType = storage.read(KeyStore.signInType_S);
    switch (signType) {
      case 'google.com':
        return 1;
      case 'facebook.com':
        return 2;
      case 'kakao':
        return 3;
      case 'apple.com':
        return 4;
      default:
        return 0;
    }
  }
}
