import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int skip = 0;
  final pageSize = 5;
  RxString pageTitle = '豆瓣250'.obs;
  late TabController tabController;
  late PageController pageController;
  late Timer _timer;

  List<Map<String, String>> categoryList = [
    {'title': LocaleKeys.tabs_home_page_douban.tr, 'source': 'Douban'},
    {'title': LocaleKeys.tabs_home_page_imdb.tr, 'source': 'Imdb'},
  ];

  // tabIndex 变化
  void tabIndexChanged(int index) {
    final map = categoryList[index];
    final title = map['title'];
    pageTitle.value = '${title}250';
  }

  void doSomeThing() {
    pageController.jumpToPage(1);
    tabIndexChanged(1);
  }

  @override
  void onInit() {
    tabController = TabController(
        initialIndex: 0, length: categoryList.length, vsync: this);
    pageController = PageController(initialPage: 0);
    print('home controller onInit');

    super.onInit();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(DateTime.now());
    });
  }

  @override
  void onClose() {
    print('HomeController onReady');
    _timer.cancel();

    super.onClose();
  }
}
