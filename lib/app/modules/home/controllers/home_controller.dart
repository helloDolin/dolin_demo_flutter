import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  RxBool flag = false.obs;
  RxDouble opcity = 1.0.obs;
  int skip = 0;
  final pageSize = 5;
  RxString pageTitle = 'IMDB250'.obs;

  late TabController tabController;
  List<Map<String, String>> categoryList = [
    {'title': '豆瓣', 'source': 'Douban'},
    {'title': 'IMDB', 'source': 'Imdb'},
  ];

  @override
  void onInit() {
    tabController = TabController(
        initialIndex: 0, length: categoryList.length, vsync: this);
    scrollController.addListener(() {
      print(
          'scrollController.position.pixels:${scrollController.position.pixels}');
      if (scrollController.position.pixels <= 100) {
        double num = scrollController.position.pixels / 100;
        // if (num <= 0.0) {
        //   num = 0.0;
        // } else if (num >= 0.8) {
        //   num = 1;
        // }
        opcity.value = num;
      }
      if (scrollController.position.pixels > 10 &&
          scrollController.position.pixels < 20) {
        if (flag.value == false) {
          flag.value = true;
        }
      }
      if (scrollController.position.pixels < 10) {
        if (flag.value == true) {
          flag.value = false;
        }
      }
    });
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
