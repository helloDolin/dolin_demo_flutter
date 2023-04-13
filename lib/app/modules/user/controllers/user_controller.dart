import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';

class UserController extends GetxController {
  //TODO: Implement UserController

  RxString deviceData = ''.obs;
  RxString scan_code = ''.obs;

  void getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    if (deviceInfo is IosDeviceInfo) {
      deviceData.value = '''name:   ${deviceInfo.name ?? ''}
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
  }
}
