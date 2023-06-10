import 'dart:io';
import 'dart:math' as math;

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dolin/app/util/toast_util.dart';
import 'package:dolin/generated/locales.g.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common_widgets/keepAliveWrapper.dart';
import '../../../../routes/app_pages.dart';
import '../../../../util/random_color_util.dart';
import '../../animate.dart';
import '../../arena_practice.dart';
import '../../async_practice.dart';
import '../../custom_paint/bezier_study.dart';
import '../../custom_paint/cake.dart';
import '../../custom_paint/charts.dart';
import '../../custom_paint/paint_and_animate.dart' as paint_and_animate;
import '../../custom_paint/spring.dart';
import '../../custom_render_object.dart';
import '../../dart_summary/dart_summary.dart';
import '../../in_common_use_widget.dart';
import '../../key.dart';
import '../../layout_practice.dart';
import '../../pieces_of_knowledge.dart';
import '../../radius_ summary.dart';
import '../../sliver.dart';
import '../../stream/stream.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStreamExpandable(context),
                _buildCustomPaintExpandable(context),
                _buildDevicePackageExpandable(context),
                _buildUrlLaunchExpandable(context),
                _buildGetXExpandable(context, title: 'GetX-dialog-snackbar'),
                Card('动画练习', () {
                  Get.to(const AnimatePractice());
                }),
                Card('Key 练习', () {
                  Get.to(const KeyPractice());
                }),
                Card('Sliver练习', () {
                  Get.to(const SliverPractice());
                }),
                Card('手撕 RenderObject', () {
                  Get.to(const CustomRenderObject());
                }),
                Obx(
                  () => AnimatedSwitcher(
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    duration: const Duration(seconds: 1),
                    child: Card(
                      'π的值为：${controller.pi.value.toString()}\n点击计算',
                      () async {
                        // controller.pi.value = 123;
                        // // 由于耗时太多，所以会造成 CircularProgressIndicator 卡住
                        // controller.mockTimeConsumingTask(1000000000);
                        // 使用 compute 创建新的 Isolate
                        final double res =
                            await compute(mockTimeConsumingTask, 1000000000);
                        controller.pi.value = res;
                      },
                      key: UniqueKey(),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
                Card('Time-Keeping', () {
                  Get.toNamed(Routes.TIME_KEEPING);
                }),
                Card('TextField', () {
                  Get.toNamed(Routes.TEXT_FIELD);
                }),
                Card('Dart 温故知新', () {
                  Get.to(const DartSummaryPage());
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
                Card('WebView', () {
                  Get.to(() => const WebView());
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
                Card('常用组件', () {
                  Get.to(() => const InCommonUseWidgetPage());
                }),
                Card('Method Channel', () async {
                  controller.getInvokeChannelInfo();
                }),
                Obx(() => Offstage(
                      offstage: controller.invokeChannelResult.value.isEmpty,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10),
                        child: Text(
                          controller.invokeChannelResult.value,
                          style: const TextStyle(wordSpacing: 3, fontSize: 16),
                        ),
                      ),
                    )),
              ],
            )),
      ),
    );
  }

  Widget _buildStreamExpandable(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          tapBodyToExpand: true,
          tapBodyToCollapse: true,
          hasIcon: false,
        ),
        header: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.indigoAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ExpandableIcon(
                  theme: const ExpandableThemeData(
                    expandIcon: Icons.arrow_right,
                    collapseIcon: Icons.arrow_drop_down,
                    iconColor: Colors.white,
                    iconSize: 28.0,
                    iconRotationAngle: math.pi / 2,
                    iconPadding: EdgeInsets.only(right: 5),
                    hasIcon: false,
                  ),
                ),
                Expanded(
                  child: Text(
                    "stream",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        collapsed: Container(),
        expanded: Column(
          children: [
            ListTile(
              title: const Text('StreamPractice'),
              onTap: () {
                Get.to(() => const StreamPractice());
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomPaintExpandable(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          tapBodyToExpand: true,
          tapBodyToCollapse: true,
          hasIcon: false,
        ),
        header: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.indigoAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ExpandableIcon(
                  theme: const ExpandableThemeData(
                    expandIcon: Icons.arrow_right,
                    collapseIcon: Icons.arrow_drop_down,
                    iconColor: Colors.white,
                    iconSize: 28.0,
                    iconRotationAngle: math.pi / 2,
                    iconPadding: EdgeInsets.only(right: 5),
                    hasIcon: false,
                  ),
                ),
                Expanded(
                  child: Text(
                    "CustomPaint",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        collapsed: Container(),
        expanded: Column(
          children: [
            ListTile(
              title: const Text('绘制+动画'),
              onTap: () {
                Get.to(const paint_and_animate.Page());
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text('cake'),
              onTap: () {
                Get.to(const Cake());
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text('BezierPage'),
              onTap: () {
                Get.to(const BezierPage());
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text('Charts'),
              onTap: () {
                Get.to(const Charts());
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text('Spring'),
              onTap: () {
                Get.to(const Spring());
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              title: const Text('学习链接'),
              onTap: () {
                launchUrlString(
                  'https://juejin.cn/book/6844733827265331214/section/6844733827214999565',
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDevicePackageExpandable(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          tapBodyToExpand: true,
          tapBodyToCollapse: true,
          hasIcon: false,
        ),
        header: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.indigoAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ExpandableIcon(
                  theme: const ExpandableThemeData(
                    expandIcon: Icons.arrow_right,
                    collapseIcon: Icons.arrow_drop_down,
                    iconColor: Colors.white,
                    iconSize: 28.0,
                    iconRotationAngle: math.pi / 2,
                    iconPadding: EdgeInsets.only(right: 5),
                    hasIcon: false,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Device&PackageInfo",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        collapsed: Container(),
        expanded: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
                        left: 20.0, right: 20.0, bottom: 0),
                    child: Text(
                      controller.pacakgeData.value,
                      style: const TextStyle(wordSpacing: 3, fontSize: 16),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildUrlLaunchExpandable(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          tapBodyToExpand: true,
          tapBodyToCollapse: true,
          hasIcon: false,
        ),
        header: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.indigoAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ExpandableIcon(
                  theme: const ExpandableThemeData(
                    expandIcon: Icons.arrow_right,
                    collapseIcon: Icons.arrow_drop_down,
                    iconColor: Colors.white,
                    iconSize: 28.0,
                    iconRotationAngle: math.pi / 2,
                    iconPadding: EdgeInsets.only(right: 5),
                    hasIcon: false,
                  ),
                ),
                Expanded(
                  child: Text(
                    "url_launcher",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        collapsed: Container(),
        expanded: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Card('打开百度', () async {
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
              } else {
                showToast('请安装微信');
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
          ],
        ),
      ),
    );
  }

  Widget _buildGetXExpandable(BuildContext context, {String? title}) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          tapBodyToExpand: true,
          tapBodyToCollapse: true,
          hasIcon: false,
        ),
        header: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.indigoAccent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ExpandableIcon(
                  theme: const ExpandableThemeData(
                    expandIcon: Icons.arrow_right,
                    collapseIcon: Icons.arrow_drop_down,
                    iconColor: Colors.white,
                    iconSize: 28.0,
                    iconRotationAngle: math.pi / 2,
                    iconPadding: EdgeInsets.only(right: 5),
                    hasIcon: false,
                  ),
                ),
                Expanded(
                  child: Text(
                    title ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        collapsed: Container(),
        expanded: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card(this.title, this.onTap, {Key? key, this.child}) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final Widget? child;

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
            gradient: LinearGradient(
              // begin: Alignment.bottomCenter,
              // end: Alignment.topCenter,
              stops: const [0, 0.9],
              colors: [bgRadomColor, titleColor],
            ),
            // boxShadow: const [BoxShadow(spreadRadius: 1, blurRadius: 1)],
          ),
          child: Row(
            mainAxisAlignment: child != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: titleColor),
              ),
              if (child != null) child!
            ],
          ),
        ));
  }
}

double mockTimeConsumingTask(int count) {
  double res = 0;
  for (int i = 1; i < count; i += 4) {
    res += (4 / i) - (4 / (i + 2));
  }
  return res;
}
