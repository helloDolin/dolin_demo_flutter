import 'package:get/get.dart';

class DetailController extends GetxController {
  RxInt count = 0.obs;

  void add() {
    count.value++;
    update();
  }

  @override
  void onInit() {
    print('DetailController init');
    super.onInit();
  }
}
