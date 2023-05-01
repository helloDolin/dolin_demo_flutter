import 'package:get/get.dart';

class DetailController extends GetxController {
  //TODO: Implement DetailController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('onInit');
  }

  @override
  void onReady() {
    super.onReady();
    print('onReady');
  }

  @override
  void onClose() {
    super.onClose();
    print('onClose');
  }

  void increment() => count.value++;
}
