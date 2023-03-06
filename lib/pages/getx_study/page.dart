import 'package:dolin_demo_flutter/pages/getx_study/controller.dart';
import 'package:dolin_demo_flutter/pages/getx_study/page2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetXPage extends StatelessWidget {
  const GetXPage({super.key});

  @override
  Widget build(context) {
    // 使用Get.put()实例化你的类，使其对当下的所有子路由可用。
    final Controller c = Get.put(Controller());

    return Scaffold(
        // 使用Obx(()=>每当改变计数时，就更新Text()。
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // 用一个简单的Get.to()即可代替Navigator.push那8行，无需上下文！
        body: Center(
            child: ElevatedButton(
                child: const Text("Go to Other"),
                onPressed: () => Get.to(() => Other()))),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Get.changeTheme(
              //     Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
              c.increment();
              // Get.snackbar("Snackbar 标题", "欢迎使用Snackbar");
              // Get.bottomSheet(Container(
              //   height: 300,
              //   color: Colors.red,
              // ));
              Get.defaultDialog();
              print(Get.width);
              print(Get.height);
            },
            child: const Icon(Icons.add)));
  }
}
