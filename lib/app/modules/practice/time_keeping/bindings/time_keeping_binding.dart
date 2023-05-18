import 'package:get/get.dart';

import '../controllers/time_keeping_controller.dart';

class TimeKeepingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeKeepingController>(
      () => TimeKeepingController(),
    );
  }
}
