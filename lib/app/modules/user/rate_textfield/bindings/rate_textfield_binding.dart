import 'package:get/get.dart';

import '../controllers/rate_textfield_controller.dart';

class RateTextfieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateTextfieldController>(
      () => RateTextfieldController(),
    );
  }
}
