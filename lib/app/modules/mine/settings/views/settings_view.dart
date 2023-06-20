import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Container(
              padding: const EdgeInsets.only(right: 56),
              alignment: Alignment.center,
              child: TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
                tabs: const [
                  Tab(
                    text: '常规',
                  ),
                  Tab(
                    text: '下载',
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              _buildGeneralSettings(),
              _buildDownloadSettings(),
            ],
          ),
        ));
  }

  SingleChildScrollView _buildGeneralSettings() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => ListTile(
              title: const Text("清除图片缓存"),
              subtitle: Text(controller.imageCacheSize.value),
              trailing: OutlinedButton(
                onPressed: () {
                  controller.cleanImageCache();
                },
                child: const Text("清除"),
              ),
            ),
          ),
          Obx(
            () => SwitchListTile(
              value: controller.settings.useSystemFontSize.value,
              onChanged: (e) {
                controller.settings.setUseSystemFontSize(e);
              },
              title: const Text("字体大小跟随系统"),
              subtitle: const Text("开启可能会有布局错乱"),
            ),
          ),
          Obx(
            () => SwitchListTile(
              value: controller.settings.isAppGrey.value,
              onChanged: (e) {
                controller.settings.setAppGrey(e);
              },
              title: const Text("APP 置灰"),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _buildDownloadSettings() {
    return SingleChildScrollView(
      child: Obx(() => Column(
            children: [
              SwitchListTile(
                value: controller.settings.downloadAllowCellular.value,
                onChanged: (e) {
                  controller.settings.setDownloadAllowCellular(e);
                },
                title: const Text("允许使用流量下载"),
              ),
            ],
          )),
    );
  }
}
