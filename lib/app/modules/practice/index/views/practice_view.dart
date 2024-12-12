// ignore_for_file: inference_failure_on_function_invocation

import 'dart:io';
import 'dart:math' as math;

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:dolin/app/common_widgets/keepalive_wrapper.dart';
import 'package:dolin/app/modules/debug/log/log.dart';
import 'package:dolin/app/modules/practice/animate.dart';
import 'package:dolin/app/modules/practice/animate_list_page.dart';
import 'package:dolin/app/modules/practice/arena_practice.dart';
import 'package:dolin/app/modules/practice/async_practice.dart';
import 'package:dolin/app/modules/practice/blur_effect.dart';
import 'package:dolin/app/modules/practice/center_slice.dart';
import 'package:dolin/app/modules/practice/chewie_demo.dart';
import 'package:dolin/app/modules/practice/custom_paint/bezier_study.dart';
import 'package:dolin/app/modules/practice/custom_paint/cake.dart';
import 'package:dolin/app/modules/practice/custom_paint/charts.dart';
import 'package:dolin/app/modules/practice/custom_paint/paint_and_animate.dart'
    as paint_and_animate;
import 'package:dolin/app/modules/practice/custom_paint/spring.dart';
import 'package:dolin/app/modules/practice/custom_render_object.dart';
import 'package:dolin/app/modules/practice/dart_summary/dart_summary.dart';
import 'package:dolin/app/modules/practice/h65wang/pages/index.dart';
import 'package:dolin/app/modules/practice/in_common_use_widget.dart';
import 'package:dolin/app/modules/practice/index/controllers/practice_controller.dart';
import 'package:dolin/app/modules/practice/interview/chengyao.dart';
import 'package:dolin/app/modules/practice/key.dart';
import 'package:dolin/app/modules/practice/layout_practice.dart';
import 'package:dolin/app/modules/practice/my_provider_page.dart';
import 'package:dolin/app/modules/practice/popup.dart';
import 'package:dolin/app/modules/practice/radius_%20summary.dart';
import 'package:dolin/app/modules/practice/scrollable_list_tab_scroller.dart';
import 'package:dolin/app/modules/practice/sliding_up_panel_page.dart';
import 'package:dolin/app/modules/practice/sliver/juejin/page.dart';
import 'package:dolin/app/modules/practice/sliver/sliver_basic.dart';
import 'package:dolin/app/modules/practice/stream/stream.dart';
import 'package:dolin/app/modules/practice/stream/stream_game.dart';
import 'package:dolin/app/modules/practice/time_line.dart';
import 'package:dolin/app/modules/practice/webview/local_html_page.dart';
import 'package:dolin/app/modules/practice/webview/webview_flutter.dart';
import 'package:dolin/app/modules/practice/wechat_friends.dart';
import 'package:dolin/app/routes/app_pages.dart';
import 'package:dolin/app/util/random_color_util.dart';
import 'package:dolin/generated/locales.g.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class PracticeView extends GetView<PracticeController> {
  const PracticeView({super.key});
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
              Card('BlurEffect', () {
                Get.to(const BlurEffect());
              }),
              Card('SlidingUpPanelPage', () {
                Get.to(const SlidingUpPanelPage());
              }),
              Card('手撕 RenderObject', () {
                Get.to(const CustomRenderObject());
              }),
              Card('手撕 Provider', () {
                Get.to(() => const MyProviderPage());
              }),
              Card('center slice', () {
                Get.to(
                  const CenterSlice(
                    title: 'img center slice',
                  ),
                );
              }),
              Card('popup(跟随widget)', () {
                Get.to(const PopupPage());
              }),
              Card('chewie', () {
                Get.to(const ChewieDemo());
              }),
              Card('AnimatedListPage', () {
                Get.to(const AnimatedListPage());
              }),
              Card('scrollable_list_tab_scroller', () {
                Get.to(
                  const ScrollableListTabPage(
                    title: 'scrollable_list_tab_scroller',
                  ),
                );
              }),
              Card('时光轴', () {
                Get.to(const TimeLinePage());
              }),
              _buildWebViewExpandable(),
              _buildInterViewExpandable(),
              _buildStreamExpandable(),
              _buildCustomPaintExpandable(),
              _buildDevicePackageExpandable(),
              _buildUrlLaunchExpandable(),
              _buildGetXExpandable(),
              _buildSliverExpandable(),
              Card('B站大神王叔不秃挑战', () {
                Get.to(const ChallengePage());
              }),
              Card('动画练习', () {
                Get.to(const AnimatePractice());
              }),
              Card('Key 练习', () {
                Get.to(const KeyPractice());
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
                    'π的值为：${controller.pi.value}\n点击计算',
                    () async {
                      // controller.pi.value = 123;
                      // // 由于耗时太多，所以会造成 CircularProgressIndicator 卡住
                      // controller.mockTimeConsumingTask(1000000000);
                      // 使用 compute 创建新的 Isolate
                      final res =
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
              Card('DLTextField', () {
                Get.toNamed(Routes.TEXT_FIELD);
              }),
              Card('Dart 温故知新', () {
                Get.to(const DartSummaryPage());
              }),
              Card('手势', () {
                Get.to(
                  const ArenaPage(),
                );
              }),
              Card('异步练习', () {
                Get.to(const AsyncPage());
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
              Obx(
                () => Card(
                    controller.scanCode.value.isEmpty
                        ? '扫码'
                        : controller.scanCode.value, () async {
                  const options = ScanOptions(
                    // set the options
                    autoEnableFlash: true,
                    strings: {
                      'cancel': '取消',
                      'flash_on': '打开闪光灯',
                      'flash_off': '关闭闪光灯',
                    },
                  );

                  final result = await BarcodeScanner.scan(options: options);
                  controller.scanCode.value = result.rawContent;

                  if (!kReleaseMode) {
                    Log.i(
                      result.type.toString(),
                    ); // The result type (barcode, cancelled, failed)
                    Log.i(result.rawContent); // The barcode content
                    Log.i(
                      result.format.toString(),
                    ); // The barcode format (as enum)
                    Log.i(result.formatNote); // If a unkn
                  }
                }),
              ),
              Card('常用组件', () {
                Get.to(() => const InCommonUseWidgetPage());
              }),
              Card('Method Channel', () async {
                await controller.getInvokeChannelInfo();
              }),
              Obx(
                () => Offstage(
                  offstage: controller.invokeChannelResult.value.isEmpty,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: Text(
                      controller.invokeChannelResult.value,
                      style: const TextStyle(wordSpacing: 3, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWebViewExpandable() {
    return ExpandableWidget(
      title: 'webView',
      children: [
        // ListTile(
        //   title: const Text('FlutterInappwebview'),
        //   onTap: () {
        //     Get.to(() => const FlutterInappwebview());
        //   },
        //   trailing: const Icon(Icons.arrow_forward_ios),
        // ),
        ListTile(
          title: const Text('WebviewFlutter'),
          onTap: () {
            Get.to(() => const WebviewFlutter());
          },
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          title: const Text('LocalWebView'),
          onTap: () {
            Get.to(() => const LocalHtmlPage());
          },
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget _buildInterViewExpandable() {
    return ExpandableWidget(
      title: '面试总结',
      children: [
        ListTile(
          title: const Text('乘耀健康'),
          onTap: () {
            Get.to(() => const ChengYaoJianKang());
          },
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget _buildSliverExpandable() {
    return ExpandableWidget(
      title: 'NestedScrollView + CustomScrollView',
      children: [
        ListTile(
          title: const Text('SliverBasic'),
          onTap: () {
            Get.to(() => const SliverBasic());
          },
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          title: const Text('仿掘金首页'),
          onTap: () {
            Get.to(() => const JuejinHomePage());
          },
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget _buildStreamExpandable() {
    return ExpandableWidget(
      title: 'Stream Practice',
      children: [
        ListTile(
          title: const Text('StreamBuilder Basics'),
          onTap: () {
            Get.to(() => const StreamPractice());
          },
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          title: const Text('Stream Game'),
          onTap: () {
            Get.to(() => const StreamGame());
          },
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget _buildCustomPaintExpandable() {
    return ExpandableWidget(
      title: '自绘',
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
            // launchUrlString(
            //   'https://juejin.cn/book/6844733827265331214/section/6844733827214999565',
            // );
          },
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget _buildDevicePackageExpandable() {
    return ExpandableWidget(
      title: 'DeviceInfo&PackageInfo',
      children: [
        Card('DeviceInfo', () {
          controller.deviceData.value.isEmpty
              ? controller.getDeviceInfo()
              : controller.deviceData.value = '';
        }),
        Obx(
          () => Offstage(
            offstage: controller.deviceData.value.isEmpty,
            child: Container(
              // color: Colors.red,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Text(
                controller.deviceData.value,
                style: const TextStyle(wordSpacing: 3, fontSize: 16),
              ),
            ),
          ),
        ),
        Card('PackageInfo', () {
          controller.pacakgeData.value.isEmpty
              ? controller.getPackageInflo()
              : controller.pacakgeData.value = '';
        }),
        Obx(
          () => Offstage(
            offstage: controller.pacakgeData.value.isEmpty,
            child: Container(
              // color: Colors.red,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                controller.pacakgeData.value,
                style: const TextStyle(wordSpacing: 3, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUrlLaunchExpandable() {
    return ExpandableWidget(
      title: 'url_launcher',
      children: [
        Card('打开百度', () async {
          // final uri = Uri.parse('https://www.baidu.com');
          // if (await canLaunchUrl(uri)) {
          //   await launchUrl(uri);
          // }
        }),
        Card('打电话', () async {
          // final uri = Uri.parse('tel:10086');
          // if (await canLaunchUrl(uri)) {
          //   await launchUrl(uri);
          // }
        }),
        Card('发短信', () async {
          // final uri = Uri.parse('sms:10086');
          // if (await canLaunchUrl(uri)) {
          //   await launchUrl(uri);
          // }
        }),
        Card('打开微信', () async {
          // final uri = Uri.parse('weixin://');
          // if (await canLaunchUrl(uri)) {
          //   await launchUrl(uri);
          // } else {
          //   showToast('请安装微信');
          // }
        }),
        Card('高德地图-导航北大', () async {
          const title = '北京大学';
          const latitude = '39.992806';
          const longitude = '116.310905';
          final uri = Uri.parse(
            '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2&poiname=$title',
          );
          debugPrint(uri.toString());
          // try {
          //   if (await canLaunchUrl(uri)) {
          //     await launchUrl(uri);
          //   } else {
          //     showToast('请安装高德地图');
          //     debugPrint('无法调起高德地图');
          //   }
          // } catch (e) {
          //   debugPrint('无法调起高德地图');
          // }
        }),
      ],
    );
  }

  Widget _buildGetXExpandable() {
    return ExpandableWidget(
      title: 'GetX-dialog-snackbar',
      children: [
        Card('get dialog', () {
          Get.defaultDialog(
            onConfirm: () => debugPrint('Ok'),
            middleText: 'Dialog made in 3 lines of code',
          );
        }),
        Card('get snackbar', () {
          Get.snackbar(
            "Hey i'm a Get SnackBar!", // title
            "It's unbelievable! I'm using SnackBar without context, without boilerplate, without Scaffold, it is something truly amazing!", // message
            // icon: const Icon(Icons.alarm),
            backgroundColor: Colors.purple,
            shouldIconPulse: true,
            onTap: (_) {},
            barBlur: 20,
            isDismissible: true,
            titleText: Container(
              width: 100,
              height: 50,
              color: Colors.red,
            ),
            messageText: Container(
              width: 100,
              height: 150,
              color: Colors.blue,
            ),
            icon: Container(
              width: 100,
              height: 150,
              color: Colors.yellow,
            ),
          );
        }),
      ],
    );
  }
}

class ExpandableWidget extends StatelessWidget {
  const ExpandableWidget({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // 根据明暗调整颜色
    final bgRadomColor = getRandomColor();
    final brightnessValue = bgRadomColor.computeLuminance();
    final titleColor = brightnessValue > 0.5 ? Colors.black : Colors.white;
    final borderColor = brightnessValue > 0.5
        ? const Color.fromARGB(255, 9, 130, 31)
        : Colors.black;
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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ExpandableIcon(
                  theme: const ExpandableThemeData(
                    expandIcon: Icons.arrow_right,
                    collapseIcon: Icons.arrow_drop_down,
                    iconColor: Colors.white,
                    iconSize: 28,
                    iconRotationAngle: math.pi / 2,
                    iconPadding: EdgeInsets.only(right: 5),
                    hasIcon: false,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
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
            ...children,
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card(this.title, this.onTap, {super.key, this.child});
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
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}

double mockTimeConsumingTask(int count) {
  var res = 0.0;
  for (var i = 1; i < count; i += 4) {
    res += (4 / i) - (4 / (i + 2));
  }
  return res;
}
