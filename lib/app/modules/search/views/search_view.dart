import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() => Text(
              controller.searchPushCount.value.toString(),
              style: const TextStyle(fontSize: 20),
            )),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => Get.offNamed('/search', arguments: {
          'searchPushCount': controller.searchPushCount.value += 1
        }),
        child: const Text('to search'),
      ),
    );
  }
}
