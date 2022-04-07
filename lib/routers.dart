import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smate/screens/home/screen_home.dart';
import 'package:smate/screens/sign/email_validation.dart';
import 'package:smate/screens/sign/screen_sign_in.dart';
import 'package:smate/screens/splash/screen_splash.dart';

class Routers {
  final allPageRouter = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(
      name: '/signIn',
      page: () => const SignInScreen(),
    ),
    GetPage(
        name: '/emailValidation', page: () => const EmailValidationScreen()),
    GetPage(name: '/home', page: () => const HomeScreen()),
  ];
}
