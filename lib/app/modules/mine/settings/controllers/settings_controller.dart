// import 'package:extended_image/extended_image.dart';
import 'package:dolin/app/services/app_settings_service.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final settings = AppSettingsService.instance;

  RxString imageCacheSize = '正在计算缓存...'.obs;

  @override
  void onInit() {
    // getImageCachedSize();
    super.onInit();
  }

  // void getImageCachedSize() async {
  //   try {
  //     imageCacheSize.value = "正在计算缓存...";
  //     var bytes = await getCachedSizeBytes();
  //     imageCacheSize.value = "${(bytes / 1024 / 1024).toStringAsFixed(1)}MB";
  //   } catch (e) {
  //     imageCacheSize.value = "缓存计算失败";
  //   }
  // }

  // void cleanImageCache() async {
  //   var result = await clearDiskCachedImages();
  //   if (!result) {
  //     // SmartDialog.showToast("清除失败");
  //   }
  //   getImageCachedSize();
  // }
}
