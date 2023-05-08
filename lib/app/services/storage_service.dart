import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../util/log.dart';

class StorageService extends GetxService {
  static StorageService get instance => Get.find<StorageService>();

  /// 首次运行
  static const String kFirstRun = "FirstRun";

  late Box settingsBox;

  Future init() async {
    final dir = await getApplicationSupportDirectory();
    Log.d('settingsBox path:${dir.path}');
    settingsBox = await Hive.openBox(
      "LocalStorage",
      path: dir.path,
    );
  }

  T getValue<T>(dynamic key, T defaultValue) {
    var value = settingsBox.get(key, defaultValue: defaultValue) as T;
    Log.d("Get LocalStorage：$key\n$value");
    return value;
  }

  Future setValue<T>(dynamic key, T value) async {
    Log.d("Set LocalStorage：$key\n$value");
    return await settingsBox.put(key, value);
  }

  Future removeValue<T>(dynamic key) async {
    Log.d("Remove LocalStorage：$key");
    return await settingsBox.delete(key);
  }
}
