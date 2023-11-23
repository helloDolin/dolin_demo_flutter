import 'package:dolin/app/modules/practice/index/controllers/practice_controller.dart';
import 'package:get/get.dart';

class PracticeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PracticeController>(
      () => PracticeController(),
    );
  }
}
