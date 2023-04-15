import 'package:get/get.dart';

class SearchController extends GetxController {
  RxInt searchPushCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final count = Get.arguments['searchPushCount'];
    searchPushCount.value = count;
  }
}
