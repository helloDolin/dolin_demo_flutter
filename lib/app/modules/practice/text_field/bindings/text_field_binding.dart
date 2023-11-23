import 'package:dolin/app/modules/practice/text_field/controllers/text_field_controller.dart';
import 'package:get/get.dart';

class TextFieldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextFieldController>(
      () => TextFieldController(),
    );
  }
}
