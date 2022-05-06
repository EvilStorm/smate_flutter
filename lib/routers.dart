import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smate/binders/binder_join_process.dart';
import 'package:smate/binders/binder_posting.dart';
import 'package:smate/screens/home/screen_home.dart';
import 'package:smate/screens/join/screen_join_process.dart';
import 'package:smate/screens/mate_post/screen_mate_posting.dart';
import 'package:smate/screens/mating/screen_mating_home.dart';
import 'package:smate/screens/sign/email_validation.dart';
import 'package:smate/screens/sign/screen_sign_in.dart';
import 'package:smate/screens/splash/screen_splash.dart';

import 'screens/common/calendar.dart';
import 'screens/home/screen_home.dart';

class Routers {
  final allPageRouter = [
    GetPage(name: '/', page: () => const MateCalendar()),
    GetPage(
      name: '/signIn',
      page: () => const SignInScreen(),
    ),
    GetPage(
        name: '/emailValidation', page: () => const EmailValidationScreen()),
    GetPage(
        name: '/joinProcess',
        page: () => const JoinProcessScreen(),
        binding: JoinProcessBinder()),
    GetPage(name: '/home', page: () => HomeScreen()),
    GetPage(name: '/my/mating', page: () => MatingHomeScreen()),
    GetPage(
        name: '/mating/create',
        page: () => MatePostingScreen(),
        binding: PostingBinder()),
  ];
}
