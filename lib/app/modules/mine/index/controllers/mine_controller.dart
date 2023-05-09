import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/app_settings_service.dart';

class MineController extends GetxController {
  final AppSettingsService settings = AppSettingsService.instance;

  final count = 0.obs;

  void increment() => count.value++;

  void login() {
    Get.toNamed(Routes.LOGIN);
  }

  /// 主题设置
  void setTheme() {
    settings.changeTheme();
  }
}
