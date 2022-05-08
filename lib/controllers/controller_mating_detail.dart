import 'package:loggy/loggy.dart';
import 'package:smate/controllers/basic_controller_fn.dart';
import 'package:get/get.dart';
import 'package:smate/models/model_mate_k.dart';
import 'package:smate/network/http_client.dart';

class MatingDetailController extends GetxController
    with BasicControllorFunctions {
  var mateModel = MateModel().obs;
  late String mateId;
  Future<bool> getMateDetail(String mId) async {
    mateId = mId;

    try {
      var response = await HttpClient.instance.get('/mate/detail/$mId');

      if (response['code'] == 200) {
        mateModel.value = MateModel.fromJson(response['data']);
        return true;
      } else {
        showMessage(response['message']);
        return false;
      }
    } catch (e) {
      logError(e);
      return false;
    }
  }

  void setMate(MateModel _model) {
    mateModel.value = _model;
  }

  void joinMate() async {
    showLoadingDialog();
    try {
      var response =
          await HttpClient.instance.post('/mate/apply/$mateId', body: {});
      if (response['code'] == 200) {
        await getMateDetail(mateId);
      }
    } catch (e) {
      logError(e);
    } finally {
      hideLoadingDialog();
    }
  }

  void joinCancelMate() async {
    showLoadingDialog();
    try {
      var response = await HttpClient.instance
          .post('/mate/apply/cancel/$mateId', body: {});
      if (response['code'] == 200) {
        await getMateDetail(mateId);
      }
    } catch (e) {
      logError(e);
    } finally {
      hideLoadingDialog();
    }
  }

  void acceptCancel(String sId) async {
    try {
      var response = await HttpClient.instance.post(
        '/mate/accept/cancel/${mateModel.value.sId}',
        body: {
          'userId': sId,
        },
      );
      if (response['code'] == 200) {
        removeMember(sId);
      }
    } catch (e) {
      logError(e);
    }
  }

  void removeMember(String mId) {
    int? index = mateModel.value.member?.joinMember
        ?.indexWhere((element) => element.sId == mId);

    if (index != null && index >= 0) {
      mateModel.value.member?.joinMember?.removeAt(index);
    }
    mateModel.refresh();
  }

  void moveJoinMember(String userId) {
    int? index = mateModel.value.member?.member
        ?.indexWhere((element) => element.sId == userId);

    if (index != null && index >= 0) {
      mateModel.value.member?.joinMember
          ?.add(mateModel.value.member!.member!.elementAt(index));
    }
    mateModel.refresh();
  }

  void memberJoin(String userId) async {
    try {
      var response = await HttpClient.instance.post(
        '/mate/accept/${mateModel.value.sId}',
        body: {
          'joinMemberId': userId,
        },
      );
      if (response['code'] == 200) {
        moveJoinMember(userId);
      } else {
        showMessage(response['message']);
      }
    } catch (e) {
      logError(e);
    }
  }

  void memberDenied(String sId) async {
    try {
      var response = await HttpClient.instance.post('/mate/join/cancel/$sId');
      if (response['code'] == 200) {}
    } catch (e) {
      logError(e);
    }
  }
}
