import 'package:dolin/app/modules/comic/index/controllers/comic_controller.dart';
import 'package:get/get.dart';

class ComicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComicController>(
      ComicController.new,
    );
  }
}
