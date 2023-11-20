import 'package:dolin/app/data/comic/comic_tag_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../apis/comic/comic.dart';

class ComicController extends GetxController with GetTickerProviderStateMixin {
  bool loading = true;
  bool error = false;
  String errMsg = '';
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

  //  SmartDialog.showLoading();
  //   await Future.delayed(const Duration(seconds: 5));
  //   SmartDialog.dismiss();

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
