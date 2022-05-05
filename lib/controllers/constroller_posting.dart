import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smate/controllers/basic_controller_fn.dart';
import 'package:get/get.dart';

class PostingController extends GetxController with BasicControllorFunctions {
  var pageIndex = 0.obs;
  var maxPageIndex = 3;

  RxList images = [].obs;
  int maxImageCount = 5;
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

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
    images.add(image?.path);
  }

  void removeImage(int index) async {
    images.removeAt(index);
  }
}
