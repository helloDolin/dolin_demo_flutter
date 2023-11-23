import 'package:dolin/app/modules/comic/index/views/comic_view.dart';
import 'package:dolin/app/modules/home/index/views/home_view.dart';
import 'package:dolin/app/modules/mine/index/views/mine_view.dart';
import 'package:dolin/app/modules/practice/index/views/practice_view.dart';
import 'package:dolin/app/services/app_settings_service.dart';
import 'package:dolin/app/util/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  RxInt currentIndex = 0.obs;

  PageController pageController = PageController();
  final List<Widget> pages = const [
    HomeView(),
    ComicView(),
    PracticeView(),
    MineView(),
  ];

  @override
  void onInit() {
    dealWithFirstRun();
    super.onInit();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
    // 点击底部 tab 时找到对应页面的 controller 然后发起请求，实现 viewWillAppear
    // CategoryController cateC = Get.find<CategoryController>();
    // cateC.reqData();
  }

  /// 处理第一次启动
  void dealWithFirstRun() {
    if (AppSettingsService.instance.firstRun) {
      AppSettingsService.instance.setNoFirstRun();
      DialogUtil.showStatement();
      // TODO(检查更新):
    } else {
      // TODO(检查更新):
    }
  }
}
