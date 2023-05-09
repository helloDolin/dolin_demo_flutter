import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import 'detail_controller.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late DetailController controller;
  final int id = Get.arguments as int;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DetailController(), tag: id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(id.toString()),
            const SizedBox(
              height: 20,
            ),
            GetBuilder(
              init: controller,
              tag: id.toString(),
              builder: (controller) => Text(controller.count.value.toString()),
            ),
            Obx(() => Text(controller.count.value.toString())),
            TextButton(
                onPressed: () {
                  controller.add();
                },
                child: const Text('+'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.DETAIL,
              arguments: id + 1, preventDuplicates: false);
        },
        child: const Text('detail'),
      ),
    );
  }
}
