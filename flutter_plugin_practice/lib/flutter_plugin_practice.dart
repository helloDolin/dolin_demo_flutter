import 'flutter_plugin_practice_platform_interface.dart';

class FlutterPluginPractice {
  Future<String?> getPlatformVersion() {
    return FlutterPluginPracticePlatform.instance.getPlatformVersion();
  }

  Future<int?> getBatteryLevel() {
    return FlutterPluginPracticePlatform.instance.getBatteryLevel();
  }
}
