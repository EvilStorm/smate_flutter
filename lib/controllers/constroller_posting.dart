import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:smate/controllers/basic_controller_fn.dart';
import 'package:get/get.dart';
import 'package:smate/models/model_tag.dart';
import 'package:smate/network/http_client.dart';

class PostingController extends GetxController with BasicControllorFunctions {
  var pageIndex = 0.obs;
  var maxPageIndex = 3;

  RxList<String> images = <String>[].obs;
  RxList<String> addedTags = <String>[].obs;
  int maxImageCount = 5;

  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final RxList<TagModel> hotTagList = <TagModel>[].obs;
  final RxList<TagModel> searchTagList = <TagModel>[].obs;

  final RxBool tagIsNotFound = false.obs;
  final RxBool showTagSearchResult = false.obs;
  final RxBool tagSearchDone = false.obs;
  var searchWord = "".obs;

  Timer? _searchTmer;

  var memberCount = 1.obs;
  var maxMemberCount = 8;

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
    super.onInit();
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
    if (memberCount.value == 1) {
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

  void removeImage(int index) async {
    images.removeAt(index);
  }
}
