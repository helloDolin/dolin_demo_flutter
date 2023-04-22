import 'package:get/get.dart';

import '../controllers/watch_info_controller.dart';

class WatchInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchInfoController>(
      () => WatchInfoController(),
    );
  }
}
