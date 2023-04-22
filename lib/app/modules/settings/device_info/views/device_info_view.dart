import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/device_info_controller.dart';

class DeviceInfoView extends GetView<DeviceInfoController> {
  const DeviceInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeviceInfoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DeviceInfoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.WATCH_INFO);
        },
        child: const Text('Routes.WATCH_INFO'),
      ),
    );
  }
}
