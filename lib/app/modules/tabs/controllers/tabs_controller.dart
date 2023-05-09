import 'package:dolin_demo_flutter/app/modules/cart/views/cart_view.dart';
import 'package:dolin_demo_flutter/app/modules/category/controllers/category_controller.dart';
import 'package:dolin_demo_flutter/app/modules/category/views/category_view.dart';
import 'package:dolin_demo_flutter/app/modules/give/views/give_view.dart';
import 'package:dolin_demo_flutter/app/modules/home/views/home_view.dart';
import 'package:dolin_demo_flutter/app/modules/user/views/user_view.dart';
import 'package:dolin_demo_flutter/app/util/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/app_settings_service.dart';

class TabsController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  final List<Widget> pages = const [
    HomeView(),
    CategoryView(),
    GiveView(),
    CartView(),
    UserView(),
  ];

  void setCurrentIndex(index) {
    currentIndex.value = index;
    // 点击底部 tab 时找到对应页面的 controller 然后发起请求，实现 viewWillAppear
    CategoryController cateC = Get.find<CategoryController>();
    // cateC.reqData();
  }

  @override
  void onInit() {
    dealWithFirstRun();
    super.onInit();
  }

  void dealWithFirstRun() async {
    if (AppSettingsService.instance.firstRun) {
      AppSettingsService.instance.setNoFirstRun();
      DialogUtil.showStatement();
      // 检查更新
    } else {
      // 检查更新
    }
  }
}
