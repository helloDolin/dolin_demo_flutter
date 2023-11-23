import 'package:dolin/app/modules/practice/time_keeping/controllers/time_keeping_controller.dart';
import 'package:get/get.dart';

class TimeKeepingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeKeepingController>(
      () => TimeKeepingController(),
    );
  }
}
