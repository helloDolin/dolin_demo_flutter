import 'dart:math';

import 'package:dolin_demo_flutter/app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RadiusSummary extends StatelessWidget {
  RadiusSummary({super.key});
  final count1 = 0.obs;
  final count2 = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          print('count1');
          return Text(count1.value.toString());
        }),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Obx(() {
            print('count2');
            return Text(count2.value.toString());
          }),
          const SizedBox(
            width: double.infinity,
          ),
          // decoration
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                image: AssetImage(AppAssets.qingmaiPng),
                fit: BoxFit.cover,
              ),
            ),
            width: 300,
            height: 300,
          ),
          // ClipRRect
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: Image.asset(
                AppAssets.qingmaiPng,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              )),
          // ClipOval
          ClipOval(
            child: Image.asset(
              AppAssets.qingmaiPng,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          // ClipPath
          ClipPath(
            clipper: StartClipper(),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.qingmaiPng),
                  fit: BoxFit.cover,
                ),
              ),
              width: 300,
              height: 300,
            ),
          ),
          // PhysicalModel
          PhysicalModel(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              AppAssets.qingmaiPng,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          )
        ],
      ))),
      floatingActionButton: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              count1.value++;
            },
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () {
              count2.value++;
            },
            child: const Icon(Icons.add_box),
          ),
        ],
      ),
    );
  }
}

class StartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = size.width / 2;
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    const angle = 2 * pi / 5;

    path.moveTo(centerX + radius * cos(0), centerY + radius * sin(0));
    for (var i = 1; i < 5; i++) {
      path.lineTo(
        centerX + radius * cos(angle * i),
        centerY + radius * sin(angle * i),
      );
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
