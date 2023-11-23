import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_plugin_practice/flutter_plugin_practice.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

mixin PrintGetLifeCircle on GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint('onInit');
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('onReady');
  }
}

/// 接口枚举
enum PortType {
  usbA('USB-A', isUSB: true),
  usbC('USB-C', isUSB: true),
  typeC('TYPE-C'),
  unknown('UNKNOWN');

  final String name;
  final bool isUSB;
  // 枚举也可以有构造函数
  // ignore: sort_constructors_first
  const PortType(this.name, {this.isUSB = false});

  static PortType fromName(String name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => PortType.unknown,
    );
  }
}

class PracticeController extends GetxController with PrintGetLifeCircle {
  RxString deviceData = ''.obs;
  RxString pacakgeData = ''.obs;
  RxString scanCode = ''.obs;
  RxString invokeChannelResult = ''.obs;
  RxDouble pi = 0.0.obs;

  Future<void> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    if (deviceInfo is IosDeviceInfo) {
      deviceData.value = '''
name:   ${deviceInfo.name ?? ''}
systemName:   ${deviceInfo.systemName ?? ''}
systemVersion:    ${deviceInfo.systemVersion ?? ''}
model:    ${deviceInfo.model ?? ''}
localizedModel:   ${deviceInfo.localizedModel ?? ''}
identifierForVendor:    ${deviceInfo.identifierForVendor ?? ''}
isPhysicalDevice:   ${deviceInfo.isPhysicalDevice}
utsname-sysname:    ${deviceInfo.utsname.sysname ?? ''}
utsname-nodename:    ${deviceInfo.utsname.nodename ?? ''}
utsname-release:    ${deviceInfo.utsname.release ?? ''}
utsname-version:    ${deviceInfo.utsname.version ?? ''}
utsname-machine:    ${deviceInfo.utsname.machine ?? ''}''';
    }
    if (deviceInfo is AndroidDeviceInfo) {}
  }

  Future<void> getPackageInflo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final String appName = packageInfo.appName;
    final String packageName = packageInfo.packageName;
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;
    pacakgeData.value = '''
appName:$appName
packageName:$packageName
version:$version
buildNumber:$buildNumber    
''';
  }

  Future<void> getInvokeChannelInfo() async {
    final FlutterPluginPractice flutterPluginPractice = FlutterPluginPractice();
    int? getBatteryLevel;
    try {
      getBatteryLevel = await flutterPluginPractice.getBatteryLevel();
    } catch (e) {
      debugPrint(e.toString());
    }

    final String? getPlatformVersion =
        await flutterPluginPractice.getPlatformVersion();

    invokeChannelResult.value =
        '电量：${getBatteryLevel ?? '获取电量异常'}\n版本：${getPlatformVersion ?? ''}';
  }

  /// mock 耗时任务
  void mockTimeConsumingTask(int count) {
    double res = 0;
    for (int i = 1; i < count; i += 4) {
      res += (4 / i) - (4 / (i + 2));
    }
    pi.value = res;
  }
}
