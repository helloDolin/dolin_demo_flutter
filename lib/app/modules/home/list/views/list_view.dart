import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/list_controller.dart';

class ListView extends GetView<ListController> {
  const ListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: {'result': '123456'});
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ListView'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'controller.count.value.toString()',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
