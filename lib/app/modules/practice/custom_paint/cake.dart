import 'dart:math';

import 'package:dolin/app/common_widgets/dl_appbar.dart';
import 'package:flutter/material.dart';

class Cake extends StatelessWidget {
  const Cake({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DLAppBar(
        title: 'cake',
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          // painter: WheelPainter(),
          foregroundPainter: WheelPainter(),
          child: Center(
            child: Container(
              color: Colors.green,
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  // 设置画笔颜色
  Paint getColoredPaint(Color color) {
    // 根据颜色返回不同的画笔
    Paint paint = Paint(); // 生成画笔
    paint.color = color; // 设置画笔颜色
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制逻辑
    double wheelSize = min(size.width, size.height) / 2; // 饼图的尺寸
    double nbElem = 6; // 分成 6 份
    double radius = (2 * pi) / nbElem; //1/6 圆
    // 包裹饼图这个圆形的矩形框
    Rect boundingRect = Rect.fromCircle(
        center: Offset(wheelSize, wheelSize), radius: wheelSize);
    // 每次画 1/6 个圆弧
    canvas.drawArc(
        boundingRect, 0, radius, true, getColoredPaint(Colors.orange));
    canvas.drawArc(
        boundingRect, radius, radius, true, getColoredPaint(Colors.grey));
    canvas.drawArc(
        boundingRect, radius * 2, radius, true, getColoredPaint(Colors.green));
    canvas.drawArc(
        boundingRect, radius * 3, radius, true, getColoredPaint(Colors.red));
    canvas.drawArc(
        boundingRect, radius * 4, radius, true, getColoredPaint(Colors.blue));
    canvas.drawArc(
        boundingRect, radius * 5, radius, true, getColoredPaint(Colors.pink));
  }

  // 判断是否需要重绘，这里我们简单的做下比较即可
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
