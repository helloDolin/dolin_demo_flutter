import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    print('preventDuplicates 置为false 后，绑定每次push都会执行 DetailBinding');
    Get.lazyPut<DetailController>(
      () => DetailController(),
    );
  }
}
