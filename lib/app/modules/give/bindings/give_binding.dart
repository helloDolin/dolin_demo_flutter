import 'package:get/get.dart';

import '../controllers/give_controller.dart';

class GiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GiveController>(
      () => GiveController(),
    );
  }
}
