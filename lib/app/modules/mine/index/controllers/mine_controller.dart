import 'dart:ui';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/app_settings_service.dart';

class MineController extends GetxController {
  final AppSettingsService settings = AppSettingsService.instance;
  RxString curLanguage = ''.obs;

  @override
  void onInit() {
    String langCode = Get.locale!.languageCode;
    if (langCode == 'zh') {
      curLanguage.value = '中文';
    }
    super.onInit();
  }

  /// 切换语言
  void changeLang() {
    String langCode = Get.locale!.languageCode;
    if (langCode == 'zh') {
      const locale = Locale('en', 'US');
      Get.updateLocale(locale);
      curLanguage.value = '中文';
    } else {
      const locale = Locale('zh', 'CN');
      Get.updateLocale(locale);
      curLanguage.value = 'English';
    }
  }

  /// 登录
  void login() {
    Get.toNamed(Routes.LOGIN);
  }

  /// 主题设置
  void setTheme() {
    settings.changeTheme();
  }
}
