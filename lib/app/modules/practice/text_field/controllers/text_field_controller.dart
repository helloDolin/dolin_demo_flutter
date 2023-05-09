import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController {
  RxString inputText = ''.obs;
  final GlobalKey<FormState> formKey = GlobalKey();
  RxString uiInfo = ''.obs;

  String getUIInfo() {
    return '''
Get.pixelRatio ${Get.pixelRatio}
Get.size ${Get.size}
Get.statusBarHeight ${Get.statusBarHeight}
kToolbarHeight $kToolbarHeight
ui.window.padding ${ui.window.padding}

ScreenUtil().screenWidth ${ScreenUtil().screenWidth}
ScreenUtil().statusBarHeight ${ScreenUtil().statusBarHeight}
ScreenUtil().bottomBarHeight ${ScreenUtil().bottomBarHeight}
''';
  }

  @override
  void onInit() {
    super.onInit();
    uiInfo.value = getUIInfo();
  }
}
