import 'dart:math';

import 'package:dolin/app/constants/constants.dart';
import 'package:flutter/material.dart';

class RadiusSummary extends StatelessWidget {
  const RadiusSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RadiusSummary'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
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
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              AppAssets.qingmaiPng,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          // FractionallySizedBox 是一个可以根据父容器的大小调整其子项大小的小部件。它允许你根据父容器的百分比来设置子项的大小。
          SizedBox(
            width: 200,
            height: 200,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.5,
              child: Container(
                color: Colors.red,
              ),
            ),
          ),
          // PhysicalModel 是一个用于创建具有形状、裁剪行为和阴影效果的小部件。它常用于创建具有物理特性的形状，如圆角、裁剪或投影效果。
          PhysicalModel(
              color: Colors.green,
              elevation: 20,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              )),
        ],
      ))),
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
