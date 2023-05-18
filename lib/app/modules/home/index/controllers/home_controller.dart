import 'package:dolin_demo_flutter/app/modules/debug/dev_view.dart';
import 'package:dolin_demo_flutter/generated/locales.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends SuperController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late PageController pageController;
  RxString pageTitle = '豆瓣250'.obs;

  List<Map<String, String>> categoryList = [
    {'title': LocaleKeys.home_douban.tr, 'source': 'Douban'},
    {'title': LocaleKeys.home_imdb.tr, 'source': 'Imdb'},
  ];

  @override
  void onInit() {
    tabController = TabController(
        initialIndex: 0, length: categoryList.length, vsync: this);
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (!kReleaseMode) {
      insertDevView();
    }
  }

  /// tabIndex 变化
  void tabIndexChanged(int index) {
    final map = categoryList[index];
    final title = map['title'];
    pageTitle.value = '${title}250';
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
    print('onDetached');
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    print('onInactive');
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    print('onPaused');
  }

  @override
  void onResumed() {
    // AppLifecycleState.resumed
    print('onResumed：应用程序是可见的，并对用户输入做出响应。恢复');
  }
}
