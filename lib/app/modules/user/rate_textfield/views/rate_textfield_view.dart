import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/dl_appbar.dart';
import '../../../../common_widgets/dl_rate_textfield.dart';
import '../controllers/rate_textfield_controller.dart';

class RateTextfieldView extends GetView<RateTextfieldController> {
  const RateTextfieldView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const DLAppBar(),

      // AppBar(
      //   title: const Text('RateTextfieldView'),
      //   centerTitle: true,
      //   actions: [
      //     TextButton(
      //         onPressed: () {
      //           controller.inputText.value = '1236767';
      //         },
      //         child: const Text('inputText'))
      //   ],
      // ),
      body: ListView(
        children: [
          Obx(() => Container(
                color: Colors.yellow,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DLTextField(
                    maxLength: 10,
                    text: controller.inputText.value,
                    onChanged: (text) {
                      controller.inputText.value = text;
                    },
                  ),
                ),
              )),
          const SizedBox(
            width: double.infinity,
            height: 50,
            child: DLTextField(
              maxLength: 10,
              text: '嘿嘿',
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 50,
            child: DLTextField(
              maxLength: 10,
              text: '',
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: TextButton(
          onPressed: () {
            print(Get.pixelRatio);
            print(Get.size);
            print(Get.statusBarHeight / Get.pixelRatio);
            print(kToolbarHeight);
            print(ui.window.padding);

            print(ScreenUtil().screenWidth);
            print(ScreenUtil().statusBarHeight);
            print(ScreenUtil().bottomBarHeight);
          },
          child: const Text('test'),
        ),
      ),
    );
  }
}
