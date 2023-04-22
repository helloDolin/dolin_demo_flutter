import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SettingsView'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'SettingsView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.DEVICE_INFO);
          },
          child: const Text('device info'),
        ));
  }
}
