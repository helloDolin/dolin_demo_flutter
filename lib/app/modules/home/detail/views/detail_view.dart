import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          controller.count.toString(),
          style: const TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          // offName + preventDuplicates为false，controller 才会每次初始化
          // Get.offNamed(Routes.DETAIL, preventDuplicates: false);
          Get.offNamed(Routes.DETAIL,
              preventDuplicates: false, arguments: {'id': 789});
        },
        child: const Text('detail'),
      ),
    );
  }
}
