import 'package:dolin_demo_flutter/app/modules/practice/custom_paint/cake.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'bezier_study.dart';
import 'charts.dart';
import 'paint_and_animate.dart' as paint_and_animate;
import 'spring.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Custom Paint'),
        ),
        body: ListView(
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
        ));
  }
}
