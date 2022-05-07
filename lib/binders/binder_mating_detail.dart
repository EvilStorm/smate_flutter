import 'package:get/get.dart';
import 'package:smate/controllers/controller_mating_detail.dart';

class MateDetailBinder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MatingDetailController());
  }
}
