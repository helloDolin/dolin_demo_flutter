import 'package:get/get.dart';

import '../controllers/list_controller.dart';

class ListBinding extends Bindings {
  @override
  void dependencies() {
//     void lazyPut<S>(
//   S Function() builder, {
//   String? tag,
//   bool fenix = false,
// })
    // Get.lazyPut<ListController>(
    //   () => ListController(),
    // );
    Get.put(ListController());
  }
}
