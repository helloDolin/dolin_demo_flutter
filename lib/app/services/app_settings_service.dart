// ignore_for_file: avoid_positional_boolean_parameters

import 'package:dolin/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingsService extends GetxController {
  static AppSettingsService get instance => Get.find<AppSettingsService>();

  bool firstRun = false;
  RxInt themeMode = 0.obs;

  @override
  void onInit() {
    firstRun = StorageService.instance.getValue(StorageService.kFirstRun, true);
    super.onInit();
  }

  /// 显示字体大小跟随系统
  RxBool useSystemFontSize = false.obs;
  void setUseSystemFontSize(bool e) {
    useSystemFontSize.value = e;
    StorageService.instance.setValue(StorageService.kUseSystemFontSize, e);
  }

  /// app 置灰
  RxBool isAppGrey = false.obs;
  void setAppGrey(bool e) {
    isAppGrey.value = e;
    StorageService.instance.setValue(StorageService.kGreyApp, e);
  }

  /// 下载是否允许使用流量
  RxBool downloadAllowCellular = true.obs;
  void setDownloadAllowCellular(bool value) {
    downloadAllowCellular.value = value;
    StorageService.instance
        .setValue(StorageService.kDownloadAllowCellular, value);
  }

  void setNoFirstRun() {
    StorageService.instance.setValue(StorageService.kFirstRun, false);
  }

  Future<void> setTheme(int i) async {
    themeMode.value = i;
    final mode = ThemeMode.values[i];

    await StorageService.instance.setValue(StorageService.kThemeMode, i);
    Get.changeThemeMode(mode);
    // await Get.forceAppUpdate(); 慎用
  }

  void changeTheme() {
    Get.dialog<void>(
      SimpleDialog(
        title: const Text('设置主题'),
        children: [
          RadioListTile<int>(
            title: const Text('跟随系统'),
            value: 0,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back<void>();
              setTheme(e ?? 0);
            },
          ),
          RadioListTile<int>(
            title: const Text('浅色模式'),
            value: 1,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back<void>();
              setTheme(e ?? 1);
            },
          ),
          RadioListTile<int>(
            title: const Text('深色模式'),
            value: 2,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back<void>();
              setTheme(e ?? 2);
            },
          ),
        ],
      ),
    );
  }
}
