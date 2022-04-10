import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/contants/constants.dart';

import 'controller_sign.dart';

class EmailSignInController extends GetxController {
  final SignController _signController = Get.find<SignController>();
  final _emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  var passwordVaildation = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();

  // Rx<String?> errorMessage = null.obs;

  EmailSignInController() {
    passwordController.addListener(() {
      if (isPasswodVaildate()) {
        if (passwordVaildation.value) return;
        passwordVaildation.value = true;
      } else {
        if (!passwordVaildation.value) return;
        passwordVaildation.value = false;
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();

    super.onClose();
  }

  bool _isEmailValidation() => _emailValid.hasMatch(emailController.text);
  bool isPasswodVaildate() => passwordController.text.length >= 8;
  bool checkInputVaildation() {
    if (emailController.text == "") {
      return false;
    }

    if (passwordController.text == "" || !isPasswodVaildate()) {
      return false;
    }

    if (passwordCheckController.text == "" ||
        passwordController.text != passwordCheckController.text) {
      return false;
    }

    return true;
  }

  void passwordReset() async {
    if (!_isEmailValidation()) {
      Get.rawSnackbar(
        message: '이메일을 입력해주세요.',
        snackPosition: SnackPosition.TOP,
        borderRadius: Constants.sapceGap,
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(Get.context!).primaryColor,
      );

      return;
    }
    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
    Get.rawSnackbar(
      message: '비밀번호 초기화 링크가 이메일로 전송되었습니다.\n이메일을 확인해주세요.',
      snackPosition: SnackPosition.TOP,
      borderRadius: Constants.sapceGap,
      duration: const Duration(seconds: 2),
      backgroundColor: Theme.of(Get.context!).primaryColor,
    );
  }

  void addAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      _signController.signInMyApp();

      // _signController.sendEmailVdalition();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: '더 복잡한 비밀번호를 사용해주세요.');
        logError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: '이미 사용중입니다.');
        logError('The account already exists for that email.');
      }
    } catch (e) {
      logError(e);
    }
  }

  void signIn() async {
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      logInfo(result);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: '이메일, 비밀번호를 확인해주세요.');
        logError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: '이메일, 비밀번호를 확인해주세요.');
        logError('Wrong password provided for that user.');
      }
    }
  }
}
