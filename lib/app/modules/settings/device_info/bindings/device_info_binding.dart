import 'package:get/get.dart';

import '../controllers/device_info_controller.dart';

class DeviceInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeviceInfoController>(
      () => DeviceInfoController(),
    );
  }
}
