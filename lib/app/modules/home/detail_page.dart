import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail_controller.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, this.id = -1});

  final int id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DetailController(), tag: widget.id.toString());
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
            Text(widget.id.toString()),
            const SizedBox(
              height: 20,
            ),
            GetBuilder(
              init: controller,
              tag: widget.id.toString(),
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
          Get.to(
            () => DetailPage(
              id: widget.id + 1,
            ),
            preventDuplicates: false,
          );
        },
        child: const Text('detail'),
      ),
    );
  }
}
