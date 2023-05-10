import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dolin_demo_flutter/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common_widgets/keepAliveWrapper.dart';
import '../../../../routes/app_pages.dart';
import '../../../../util/random_color_util.dart';
import '../../arena_practice.dart';
import '../../async_practice.dart';
import '../../customer_paint_view.dart';
import '../../dart_summary/dart_summary.dart';
import '../../in_common_use_widget.dart';
import '../../layout_practice.dart';
import '../../pieces_of_knowledge.dart';
import '../../radius_ summary.dart';
import '../../video.dart';
import '../../webView.dart';
import '../../wechat_friends.dart';
import '../controllers/practice_controller.dart';

class PracticeView extends GetView<PracticeController> {
  const PracticeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.index_practice.tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Card('TextField', () {
                  Get.toNamed(Routes.TEXT_FIELD);
                }),
                Card('Dart 温故知新', () {
                  Get.to(const DartSummaryPage());
                }),
                Card('手绘 Widget', () {
                  Get.to(const CustomPaintPage());
                }),
                Card('手势竞技场', () {
                  Get.to(const ArenaPage(
                    title: 'hello',
                  ));
                }),
                Card('异步练习', () {
                  Get.to(const AsyncPage());
                }),
                Card('小知识点总结', () {
                  Get.to(const PiecesOfKnowledge());
                }),
                Card('各种圆角总结', () {
                  Get.to(const RadiusSummary());
                }),
                Card('微信朋友圈', () {
                  Get.to(const WechatFriends());
                }),
                Card('LayoutPractice', () {
                  Get.to(() => const LayoutPractice());
                }),
                Card('VideoPage', () {
                  Get.to(() => const VideoPage());
                }),
                Card('WebView', () {
                  Get.to(() => const WebView());
                }),
                Card('获取设备信息', () {
                  controller.deviceData.value.isEmpty
                      ? controller.getDeviceInfo()
                      : controller.deviceData.value = '';
                }),
                Obx(() => Offstage(
                      offstage: controller.deviceData.value.isEmpty,
                      child: Container(
                        // color: Colors.red,
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10),
                        child: Text(
                          controller.deviceData.value,
                          style: const TextStyle(wordSpacing: 3, fontSize: 16),
                        ),
                      ),
                    )),
                Card('PackageInfo', () {
                  controller.pacakgeData.value.isEmpty
                      ? controller.getPackageInflo()
                      : controller.pacakgeData.value = '';
                }),
                Obx(() => Offstage(
                      offstage: controller.pacakgeData.value.isEmpty,
                      child: Container(
                        // color: Colors.red,
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10),
                        child: Text(
                          controller.pacakgeData.value,
                          style: const TextStyle(wordSpacing: 3, fontSize: 16),
                        ),
                      ),
                    )),
                Card('打开浏览器', () async {
                  final Uri uri = Uri.parse('https://www.baidu.com');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                }),
                Card('打电话', () async {
                  final Uri uri = Uri.parse('tel:10086');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                }),
                Card('发短信', () async {
                  final Uri uri = Uri.parse('sms:10086');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                }),
                Card('打开微信', () async {
                  final Uri uri = Uri.parse('weixin://');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                }),
                Card('高德地图-导航北大', () async {
                  String title = "北京大学";
                  String latitude = "39.992806";
                  String longitude = "116.310905";
                  Uri uri = Uri.parse(
                      '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2&poiname=$title');
                  print(uri);
                  try {
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      print('无法调起高德地图');
                    }
                  } catch (e) {
                    print('无法调起高德地图');
                  }
                }),
                Obx(() => Card(
                        controller.scanCode.value.isEmpty
                            ? '扫码'
                            : controller.scanCode.value, () async {
                      var options = const ScanOptions(
                        // set the options
                        autoEnableFlash: true,
                        strings: {
                          'cancel': '取消',
                          'flash_on': '打开闪光灯',
                          'flash_off': '关闭闪光灯'
                        },
                      );

                      var result = await BarcodeScanner.scan(options: options);
                      controller.scanCode.value = result.rawContent;

                      print(result
                          .type); // The result type (barcode, cancelled, failed)
                      print(result.rawContent); // The barcode content
                      print(result.format); // The barcode format (as enum)
                      print(result.formatNote); // If a unkn
                    })),
                Card('更改主题', () {
                  Get.changeTheme(
                      Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                }),
                Card('get dialog', () {
                  Get.defaultDialog(
                      onConfirm: () => print("Ok"),
                      middleText: "Dialog made in 3 lines of code");
                }),
                Card('get snackbar', () {
                  Get.snackbar(
                    "Hey i'm a Get SnackBar!", // title
                    "It's unbelievable! I'm using SnackBar without context, without boilerplate, without Scaffold, it is something truly amazing!", // message
                    icon: const Icon(Icons.alarm),
                    shouldIconPulse: true,
                    onTap: (_) {},
                    barBlur: 20,
                    isDismissible: true,
                    duration: const Duration(seconds: 3),
                  );
                }),
                Card('常用组件', () {
                  Get.to(() => const InCommonUseWidgetPage());
                }),
              ],
            )),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card(this.title, this.onTap, {Key? key}) : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // 根据明暗调整颜色
    final bgRadomColor = getRandomColor();
    final brightnessValue = bgRadomColor.computeLuminance();
    final titleColor = brightnessValue > 0.5 ? Colors.black : Colors.white;
    final borderColor = brightnessValue > 0.5
        ? const Color.fromARGB(255, 9, 130, 31)
        : Colors.black;
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: bgRadomColor,
            border: Border.all(color: borderColor, width: 1.h),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Text(
            title,
            style: TextStyle(color: titleColor),
          ),
        ));
  }
}
