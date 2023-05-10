import 'package:dolin_demo_flutter/app/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/app_settings_service.dart';

class MineController extends GetxController {
  final AppSettingsService settings = AppSettingsService.instance;
  RxString curLanguage = ''.obs;

  @override
  void onInit() {
    String langCode = Get.locale!.languageCode;
    if (langCode == 'zh') {
      curLanguage.value = 'Change to English';
    } else if (langCode == 'en') {
      curLanguage.value = '切换为中文';
    }
    super.onInit();
  }

  /// 切换语言
  void changeLang() {
    String langCode = Get.locale!.languageCode;
    if (langCode == 'zh') {
      const locale = Locale('en', 'US');
      Get.updateLocale(locale);
      curLanguage.value = '切换为中文';
    } else {
      const locale = Locale('zh', 'CN');
      Get.updateLocale(locale);
      curLanguage.value = 'Change to English';
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

  void checkUpdate() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          "发现新版本 2.0.0",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        content: const Text(
          'TODO:新版本特性 mock',
          style: TextStyle(fontSize: 14, height: 1.4),
        ),
        actionsPadding: const EdgeInsets.all(12),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("取消"),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {
                    launchUrlString(
                      'https://www.baidu.com',
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: const Text("更新"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void about() {
    Get.dialog(
      AboutDialog(
        applicationIcon: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(.2),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppAssets.logoPng,
              width: 48,
              height: 48,
            ),
          ),
        ),
        applicationName: "Dolin Demo",
        applicationVersion: "Flutter 学习、总结、提高",
        applicationLegalese: "@DOLIN",
      ),
    );
  }
}
