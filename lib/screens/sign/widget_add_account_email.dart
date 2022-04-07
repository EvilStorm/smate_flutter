import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/controllers/controller_email_sign_in.dart';

class AddAccountWithEmail extends StatefulWidget {
  final double? height;
  const AddAccountWithEmail({Key? key, this.height = 350}) : super(key: key);

  @override
  _AddAccountWithEmailState createState() => _AddAccountWithEmailState();
}

class _AddAccountWithEmailState extends State<AddAccountWithEmail> {
  final EmailSignInController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(
            flex: 1,
          ),
          TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '이메일',
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          TextField(
            controller: controller.passwordController,
            obscureText: true,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '비밀번호',
            ),
          ),
          Obx(
            () => Visibility(
              visible: !controller.passwordVaildation.value,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  0.0,
                  Constants.sapceGap / 2,
                  0.0,
                  0.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error,
                      size: 22,
                      color: Theme.of(context).errorColor,
                    ),
                    const SizedBox(
                      width: Constants.sapceGap / 2,
                    ),
                    Text(
                      '8자리 이상 입력해주세요.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          TextField(
            controller: controller.passwordCheckController,
            obscureText: true,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '비밀번호 확인',
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                if (!controller.checkInputVaildation()) {
                  return;
                }
                controller.addAccount();
              },
              child: const Text(
                '회원가입',
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
