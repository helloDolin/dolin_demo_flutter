import 'package:dolin_demo_flutter/app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger_flutter_plus/logger_flutter_plus.dart';

class LogView extends StatelessWidget {
  const LogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('摇晃手机返回'),
      ),
      body: ShakeDetectorWidget(
        shakeDetector: DefaultShakeDetector(onPhoneShake: () {
          Get.back();
        }),
        child: LogConsoleWidget(
          logConsoleManager: StorageService.instance.logConsoleManager,
          theme: LogConsoleTheme.byTheme(Theme.of(context)),
        ),
      ),
    );
  }
}
