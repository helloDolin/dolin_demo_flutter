import 'package:get/get.dart';

import '../controllers/text_field_controller.dart';

class TextFieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextFieldController>(
      () => TextFieldController(),
    );
  }
}
