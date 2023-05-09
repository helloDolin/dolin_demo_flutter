import 'package:get/get.dart';

import 'storage_service.dart';

class AppSettingsService extends GetxController {
  static AppSettingsService get instance => Get.find<AppSettingsService>();
  var firstRun = false;

  @override
  void onInit() {
    firstRun = StorageService.instance.getValue(StorageService.kFirstRun, true);
    super.onInit();
  }

  void setNoFirstRun() {
    StorageService.instance.setValue(StorageService.kFirstRun, false);
  }
}
