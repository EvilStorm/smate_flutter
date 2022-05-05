import 'package:get/get.dart';
import 'package:smate/controllers/constroller_posting.dart';

class PostingBinder implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostingController());
  }
}
