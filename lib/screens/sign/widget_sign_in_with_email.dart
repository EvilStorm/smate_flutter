import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smate/controllers/controller_email_sign_in.dart';
import 'package:smate/screens/sign/widget_add_account_email.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({
    Key? key,
  }) : super(key: key);

  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final EmailSignInController controller = Get.find();

  void showAddAccount() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
            16.0, 16.0, 16.0, MediaQuery.of(context).viewInsets.bottom),
        child: const AddAccountWithEmail(
          height: 350,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => showAddAccount(),
              child: Text(
                '회원가입',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            TextButton(
              onPressed: () => controller.passwordReset(),
              child: Text(
                '비밀번호 초기화',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
        const Spacer(
          flex: 1,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              controller.signIn();
            },
            child: const Text(
              '로그인',
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
