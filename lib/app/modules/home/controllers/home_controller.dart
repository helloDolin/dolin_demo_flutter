import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool flag = false.obs;
  RxDouble opcity = 0.0.obs;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels <= 100) {
        double num = scrollController.position.pixels / 100;
        if (num <= 0.0) {
          num = 0.0;
        } else if (num >= 0.9) {
          num = 1;
        }

        opcity.value = num;
        print(opcity.value);
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
}
