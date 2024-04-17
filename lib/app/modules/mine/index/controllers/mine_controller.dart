import 'package:dolin/app/constants/app_assets.dart';
import 'package:dolin/app/routes/app_pages.dart';
import 'package:dolin/app/services/app_settings_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MineController extends GetxController {
  final AppSettingsService settings = AppSettingsService.instance;
  RxString curLanguage = ''.obs;
  final GlobalKey key1 = GlobalKey();
  final GlobalKey key2 = GlobalKey();

  bool guideShowed = false; // 新人引导是否已经展示

  /// 切换语言
  void changeLang() {
    final langCode = Get.locale!.languageCode;
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
    Get.toNamed<void>(Routes.LOGIN);
  }

  /// 主题设置
  void setTheme() {
    settings.changeTheme();
  }

  void checkUpdate() {
    Get.dialog<void>(
      AlertDialog(
        title: const Text(
          '发现新版本 2.0.0',
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
                  onPressed: Get.back<void>,
                  child: const Text('取消'),
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
                  child: const Text('更新'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> about() async {
    final packageInfo = await PackageInfo.fromPlatform();
    await Get.dialog<void>(
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
        applicationName: packageInfo.appName,
        applicationVersion: '版本号：${packageInfo.version}',
        applicationLegalese: '@DOLIN',
      ),
    );
  }

  @override
  void onInit() {
    final langCode = Get.locale!.languageCode;
    if (langCode == 'zh') {
      curLanguage.value = 'Change to English';
    } else if (langCode == 'en') {
      curLanguage.value = '切换为中文';
    }
    super.onInit();
  }
}
