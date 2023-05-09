import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mine_controller.dart';

class MineView extends GetView<MineController> {
  const MineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MineView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MineView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
