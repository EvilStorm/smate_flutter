import 'package:flutter/material.dart';
import 'package:smate/contants/constants.dart';
import 'package:smate/screens/common/circular_progress.dart';
import 'package:smate/screens/sign/thrid_party_sign_in/widget_border_horizental.dart';

import 'thrid_party_sign_in/widget_btns_section.dart';
import 'widget_sign_in_with_email.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).backgroundColor,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.sapceGap),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: Constants.sapceGap * 4,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SignIn',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      const SizedBox(height: 300.0, child: SignInWithEmail()),
                      const SizedBox(
                        height: Constants.sapceGap / 2,
                      ),
                      const SizedBox(
                        height: Constants.sapceGap * 2,
                      ),
                      const HorizentalBorder(),
                      const SizedBox(
                        height: Constants.sapceGap * 2,
                      ),
                      ThirdPartySignInSection(
                        height: 100,
                      ),
                      const SizedBox(
                        height: Constants.sapceGap * 4,
                      ),
                    ],
                  ),
                ),
                const Positioned.fill(
                  child: Visibility(
                    visible: false,
                    child: CircularProgress(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
