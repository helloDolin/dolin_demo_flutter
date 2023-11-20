import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  RxInt count = 0.obs;

  void add() {
    count.value++;
    update();
  }

  @override
  void onInit() {
    debugPrint('DetailController init');
    super.onInit();
  }
}
