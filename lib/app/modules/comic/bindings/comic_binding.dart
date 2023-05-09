import 'package:get/get.dart';

import '../controllers/comic_controller.dart';

class ComicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComicController>(
      () => ComicController(),
    );
  }
}
