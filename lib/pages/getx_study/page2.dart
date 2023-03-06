import 'package:dolin_demo_flutter/pages/getx_study/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Other extends StatelessWidget {
  // 你可以让Get找到一个正在被其他页面使用的Controller，并将它返回给你。
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // 访问更新后的计数变量
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}
