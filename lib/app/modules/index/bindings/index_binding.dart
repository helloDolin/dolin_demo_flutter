// ignore_for_file: cascade_invocations

import 'package:dolin/app/modules/comic/index/controllers/comic_controller.dart';
import 'package:dolin/app/modules/home/index/controllers/home_controller.dart';
import 'package:dolin/app/modules/index/controllers/index_controller.dart';
import 'package:dolin/app/modules/mine/index/controllers/mine_controller.dart';
import 'package:dolin/app/modules/practice/index/controllers/practice_controller.dart';
import 'package:get/get.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    // lazyPut：在调用时才进行初始化
    Get.lazyPut<IndexController>(
      () => IndexController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ComicController>(
      () => ComicController(),
    );
    Get.lazyPut<PracticeController>(
      () => PracticeController(),
    );
    Get.lazyPut<MineController>(
      () => MineController(),
    );
  }
}
