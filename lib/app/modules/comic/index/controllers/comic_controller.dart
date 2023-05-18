import 'package:dolin/app/data/comic/comic_tag_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../apis/comic/comic.dart';

class ComicController extends GetxController with GetTickerProviderStateMixin {
  var loading = true;
  var error = false;
  var errMsg = '';
  List<ComicTagMoel> categores = [];
  late TabController tabController;

  @override
  void onInit() {
    // reqCategores();
    mockReq();
    super.onInit();
  }

  void mockReq() async {
    await Future.delayed(const Duration(seconds: 2));
    tabController = TabController(length: 4, vsync: this);
    loading = false;
    update();
  }

  void reqCategores() async {
    try {
      loading = true;
      error = false;
      categores = await ComicAPI.category();
      tabController = TabController(length: categores.length, vsync: this);
      update();
    } catch (e) {
      errMsg = e.toString();
      error = true;
    } finally {
      loading = false;
      update();
    }
  }
}
