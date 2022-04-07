import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/controllers/controller_sign.dart';

class EmailValidationScreen extends GetView<SignController> {
  const EmailValidationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '이메일 인증 후 사용할 수 있습니다.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              '인증 메일이 수신에 4~5분이 소요될 수 있습니다.\n메일이 도착하지 않으면 재전송 버튼을 눌러주세요',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 320,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      width: 150,
                      child: Obx(
                        () => ElevatedButton(
                            onPressed: () {
                              controller.enabledVerifyEmail.value
                                  ? controller.sendEmailVdalition()
                                  : null;
                            },
                            child: Text(
                              (controller.enabledVerifyEmail.value)
                                  ? '재요청'
                                  : controller.remindTime.value.toString(),
                            )),
                      )),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.signOut();
                      },
                      child: const Text(
                        '로그아웃',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
