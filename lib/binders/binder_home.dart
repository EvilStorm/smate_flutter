import 'package:get/get.dart';
import 'package:smate/controllers/controller_home.dart';
import 'package:smate/controllers/controller_main.dart';
import 'package:smate/controllers/controller_mating.dart';

class HomeBinder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MateingController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MainController());
  }
}
