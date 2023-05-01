import 'package:get/get.dart';

class ListController extends SuperController {
  RxString id = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final param = Get.arguments;
    final param2 = Get.parameters;
    id.value = param['id'].toString();
    print('onInit');
    print(param);
    print(param2);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('onReady');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print('onClose');
  }

  /// AppLifecycleState ----------------begin
  /// resumed  inactive  paused  detached
  @override
  void onDetached() {
    // TODO: implement onDetached

    print('onDetached');
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
    print('onInactive');
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
    print('onPaused');
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
    print('onResumed');
  }

  /// AppLifecycleState ----------------end

  @override
  void didChangeMetrics() {
    print('the window size did change');
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    print('platform change ThemeMode');
    super.didChangePlatformBrightness();
  }
}
