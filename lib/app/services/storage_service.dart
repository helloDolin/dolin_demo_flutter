import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../log/log.dart';

class StorageService extends GetxService {
  static StorageService get instance => Get.find<StorageService>();

  /// 首次运行
  static const String kFirstRun = "FirstRun";

  /// 显示模式
  /// * [0] 跟随系统
  /// * [1] 浅色模式
  /// * [2] 深色模式
  static const String kThemeMode = "ThemeMode";

  /// 显示字体大小跟随系统
  static const String kUseSystemFontSize = "UseSystemFontSize";

  /// 下载是否允许使用流量
  static const String kDownloadAllowCellular = "DownloadAllowCellular";

  late Box settingsBox;

  Future init() async {
    final dir = await getApplicationSupportDirectory();
    Log.d('settingsBox path:\n${dir.path}');
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
