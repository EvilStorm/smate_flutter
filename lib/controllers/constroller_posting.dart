import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/contants/key_store.dart';
import 'package:smate/controllers/basic_controller_fn.dart';
import 'package:get/get.dart';
import 'package:smate/controllers/contoller_user_info.dart';
import 'package:smate/controllers/controller_main.dart';
import 'package:smate/models/model_mate_k.dart';
import 'package:smate/models/model_search_locale.dart';
import 'package:smate/models/model_tag.dart';
import 'package:smate/network/http_client.dart';

class PostingController extends GetxController with BasicControllorFunctions {
  final storage = GetStorage();
  final FirebaseStorage fstorage = FirebaseStorage.instance;

  var pageIndex = 0.obs;
  var maxPageIndex = 3;

  RxList<String> images = <String>[].obs;
  RxList<String> addedTags = <String>[].obs;
  int maxImageCount = 5;

  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController localeController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final RxList<TagModel> hotTagList = <TagModel>[].obs;
  final RxList<TagModel> searchTagList = <TagModel>[].obs;
  final RxList<LocaleSearchModel> searchLocaleList = <LocaleSearchModel>[].obs;

  final RxBool tagIsNotFound = false.obs;
  final RxBool showTagSearchResult = false.obs;
  final RxBool tagSearchDone = false.obs;
  var selectedDate = DateTime.now().obs;
  var dateSelected = false.obs;
  var localeSelected = LocaleSearchModel().obs;

  var selectedTime = DateTime.now().obs;
  var timeSelected = false.obs;

  var searchWord = "".obs;

  Timer? _searchTmer;

  var memberCount = 2.obs;
  var maxMemberCount = 8;

  var ageDontCare = true.obs;
  var ageRange = RangeValues(0, 1).obs;

  List<String> imageUrl = [];

  void clearSearch() {
    searchController.text = "";
    tagIsNotFound.value = false;
    showTagSearchResult.value = false;
    tagSearchDone.value = false;
    searchTagList.clear();
    searchWord.value = "";
  }

  @override
  void onInit() {
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        return;
      }
      showTagSearchResult.value = true;
      searchWord.value = searchController.text;
      _searchTmer?.cancel();

      _searchTmer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        logError(' DO SEARCH Word: ${searchController.text}');
        searchTag();
        timer.cancel();
      });
    });

    localeController.addListener(() {
      if (localeController.text.isEmpty) {
        return;
      }

      _searchTmer?.cancel();

      _searchTmer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        searchLocale();
        timer.cancel();
      });
    });

    super.onInit();
  }

  void setMateDate(DateTime date) {
    selectedDate.value = date;
    dateSelected.value = true;
  }

  void setMateTime(DateTime date) {
    selectedTime.value = date;
    timeSelected.value = true;
  }

  bool isMemberMax() {
    if (memberCount.value >= maxMemberCount) {
      return true;
    }
    return false;
  }

  void addMember() {
    if (isMemberMax()) {
      return;
    }
    memberCount.value = memberCount.value + 1;
  }

  void removeMember() {
    if (memberCount.value == 2) {
      return;
    }
    memberCount.value = memberCount.value - 1;
  }

  void getTagList() async {
    if (hotTagList.isNotEmpty) {
      return;
    }
    final response = await HttpClient.instance.get('/tag/hot');

    if (response['code'] == 200) {
      hotTagList.value = (response['data'] as List)
          .map((item) => TagModel.fromJson(item))
          .toList();
    }
  }

  void searchTag() async {
    tagIsNotFound.value = false;
    showTagSearchResult.value = true;

    if (searchController.text.trim().isEmpty) {
      return;
    }
    tagSearchDone.value = false;
    searchTagList.clear();
    final response = await HttpClient.instance
        .get('/tag/search/${searchController.text.trim()}');

    if (response['code'] == 200) {
      searchTagList.value = (response['data'] as List)
          .map((item) => TagModel.fromJson(item))
          .toList();
    } else {
      tagIsNotFound.value = true;
    }
    tagSearchDone.value = true;
  }

  void clearSearchLocale() {
    localeController.text = "";
    searchLocaleList.clear();
  }

  void searchLocale() async {
    if (localeController.text.trim().isEmpty) {
      return;
    }

    searchLocaleList.clear();
    final response = await HttpClient.instance
        .get('/briefAddr/search/${localeController.text.trim()}');

    if (response['code'] == 200) {
      searchLocaleList.value = (response['data'] as List)
          .map((item) => LocaleSearchModel.fromJson(item))
          .toList();
    }
  }

  void addTag(String tag) {
    clearSearch();
    if (addedTags.contains(tag)) {
      return;
    }
    addedTags.add(tag);
  }

  void removeTag(String tag) {
    addedTags.remove(tag);
  }

  bool back() {
    if (pageIndex.value == 0) {
      return true;
    } else {
      prev();
      return false;
    }
  }

  bool isLastPage() {
    if (pageIndex.value + 1 == maxPageIndex) {
      return true;
    }
    return false;
  }

  void next() {
    if (isLastPage()) {
      return;
    }
    pageIndex.value = pageIndex.value + 1;
  }

  void prev() {
    if (pageIndex.value == 0) {
      return;
    }
    pageIndex.value = pageIndex.value - 1;
  }

  void addIamge() async {
    if (images.length >= maxImageCount) {
      return;
    }

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      images.add(image.path);
    }
  }

  Future<bool> postingImages() async {
    for (var image in images) {
      String? result = await fileUpload(image);
      if (result != null) {
        imageUrl.add(result);
      }
    }
    return true;
  }

  Future<String?> fileUpload(String path) async {
    try {
      String uploadFileName =
          '${storage.read(KeyStore.userID_I)}_${DateTime.now().millisecondsSinceEpoch}';

      Reference ref = fstorage.ref().child('images/$uploadFileName');
      await ref.putFile(File(path));
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      logError(e);
      return null;
    }
  }

  void removeImage(int index) async {
    images.removeAt(index);
  }

  void postStyleMate() async {
    if (!postingValidation()) {
      return;
    }
    showLoadingDialog();
    await postingImages();

    try {
      var response = await HttpClient.instance.post(
        '/mate',
        body: {
          'images': imageUrl,
          'title': titleTextController.text.trim(),
          'message': descTextController.text.trim(),
          'locationStr': localeSelected.value.dong,
          'mateDate': selectedDate.value.toString(),
          'tags': addedTags,
          'maxAge': ageDontCare.value ? 0 : ageRange.value.end.round(),
          'minAge': ageDontCare.value ? 0 : ageRange.value.start.round(),
        },
      );

      if (response['code'] == 200) {
        var mate = MateModel.fromJson(response['data']);
        MainController _controller = Get.find();
        _controller.addMainMate(mate);

        Get.back();
      } else {
        showRetryMessage();
      }
    } catch (e) {
      logError(e);
      showRetryMessage();
    } finally {
      hideLoadingDialog();
    }
  }

  bool postingValidation() {
    if (titleTextController.text.isEmpty) {
      showMessage('제목을 입력해주세요.');
      pageIndex.value = 0;
      return false;
    }

    if (descTextController.text.isEmpty) {
      showMessage('소개글을 적어주세요');
      pageIndex.value = 0;
      return false;
    }

    if (addedTags.isEmpty) {
      showMessage('최소 하나의 테그는 필요합니다.');
      pageIndex.value = 1;
      return false;
    }
    if (!dateSelected.value) {
      showMessage('날자를 입력해주새요.');
      return false;
    }

    if (!timeSelected.value) {
      showMessage('시간을 입력해주새요.');
      return false;
    }

    if (localeSelected.value.fullAddress == null) {
      showMessage('장소를 입력해주새요.');
      return false;
    }

    selectedDate.value.subtract(Duration(
        hours: selectedTime.value.hour, minutes: selectedTime.value.minute));

    return true;
  }
}
