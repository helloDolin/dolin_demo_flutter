import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  int skip = 0;
  final pageSize = 5;
  RxString pageTitle = '豆瓣250'.obs;
  late TabController tabController;
  late PageController pageController;

  List<Map<String, String>> categoryList = [
    {'title': '豆瓣', 'source': 'Douban'},
    {'title': 'IMDB', 'source': 'Imdb'},
  ];

  // tabIndex 变化
  void tabIndexChanged(int index) {
    final map = categoryList[index];
    final title = map['title'];
    pageTitle.value = '${title}250';
  }

  @override
  void onInit() {
    tabController = TabController(
        initialIndex: 0, length: categoryList.length, vsync: this);
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onReady() {
    print('HomeController onReady');
    super.onReady();
  }

  @override
  void onClose() {
    print('HomeController onReady');
    super.onClose();
  }
}
