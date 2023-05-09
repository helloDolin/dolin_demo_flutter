import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'storage_service.dart';

class AppSettingsService extends GetxController {
  static AppSettingsService get instance => Get.find<AppSettingsService>();
  var firstRun = false;
  RxInt themeMode = 0.obs;

  @override
  void onInit() {
    firstRun = StorageService.instance.getValue(StorageService.kFirstRun, true);
    super.onInit();
  }

  void setNoFirstRun() {
    StorageService.instance.setValue(StorageService.kFirstRun, false);
  }

  void setTheme(int i) {
    themeMode.value = i;
    var mode = ThemeMode.values[i];

    StorageService.instance.setValue(StorageService.kThemeMode, i);
    Get.changeThemeMode(mode);
  }

  void changeTheme() {
    Get.dialog(
      SimpleDialog(
        title: const Text("设置主题"),
        children: [
          RadioListTile<int>(
            title: const Text("跟随系统"),
            value: 0,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 0);
            },
          ),
          RadioListTile<int>(
            title: const Text("浅色模式"),
            value: 1,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 1);
            },
          ),
          RadioListTile<int>(
            title: const Text("深色模式"),
            value: 2,
            groupValue: themeMode.value,
            onChanged: (e) {
              Get.back();
              setTheme(e ?? 2);
            },
          ),
        ],
      ),
    );
  }
}
