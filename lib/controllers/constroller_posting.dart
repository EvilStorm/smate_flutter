import 'package:smate/controllers/basic_controller_fn.dart';
import 'package:get/get.dart';

class PostingController extends GetxController with BasicControllorFunctions {
  var pageIndex = 0.obs;
  var maxPageIndex = 5;

  RxList images = [].obs;
}
