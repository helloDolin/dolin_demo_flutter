import 'package:get/get.dart';

class ListController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final param = Get.arguments;
    final param2 = Get.parameters;
    print(param);
    print(param2);
  }

  void increment() => count.value++;
}
