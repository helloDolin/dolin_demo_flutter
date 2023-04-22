import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../home/controllers/home_controller.dart';
import '../controllers/watch_info_controller.dart';

class WatchInfoView extends GetView<WatchInfoController> {
  const WatchInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WatchInfoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WatchInfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Get.until是从当前页面一层一层地返回，当到达BPage时停止。
          // Get.offUntil是销毁页面并进入新的页面，与原生方法Navigation.pushAndRemoveUntil的用法相同，
          // 这里的BPage和之前的BPage已经不是同一个了
          Get.until((route) => Get.currentRoute == Routes.TABS);
          HomeController homeC = Get.find<HomeController>();
          homeC.doSomeThing();
        },
        child: const Text(
            'Get.until((route) => Get.currentRoute == Routes.SETTINGS)'),
      ),
    );
  }
}
