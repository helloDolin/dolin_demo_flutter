import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/comic_controller.dart';

class ComicView extends GetView<ComicController> {
  const ComicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ComicView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ComicView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
