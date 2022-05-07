import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/controllers/basic_controller_fn.dart';
import 'package:smate/models/model_mate_k.dart';
import 'package:smate/network/http_client.dart';

class MainController extends GetxController with BasicControllorFunctions {
  RxList<MateModel> mateList = <MateModel>[].obs;

  int pageCount = 0;

  @override
  void onInit() {
    getMainMate();
    super.onInit();
  }

  void getMainMate() async {
    final response = await HttpClient.instance.get("/mate/page/$pageCount");

    if (response['code'] == 200) {
      mateList.value = (response['data'] as List)
          .map((item) => MateModel.fromJson(item))
          .toList();
      logInfo(' mateList size : ${mateList.length}');
    }
  }

  void addMainMate(MateModel newMate) {
    mateList.insert(0, newMate);
  }
}
