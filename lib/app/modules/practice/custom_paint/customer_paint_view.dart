// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';

import 'coordinate.dart';

class CustomPaintPage extends StatefulWidget {
  const CustomPaintPage({Key? key}) : super(key: key);

  @override
  State<CustomPaintPage> createState() => _CustomPaintPageState();
}

class _CustomPaintPageState extends State<CustomPaintPage> {
  // ignore: slash_for_doc_comments
  /**
   * @name: getTextPainter
   * @description: 获取TextPainter小控件属性
   * @param {*}
   * @return {*}
  */
  getTextPainter(BuildContext context, String text, TextStyle style,
      double maxWidth, int maxLines) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final TextPainter textPainter = TextPainter(
        locale: WidgetsBinding.instance.window.locale,
        text: TextSpan(text: text, style: style),
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter;
  }

  @override
  void initState() {
    // 第一帧绘制结束回调
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      debugPrint('第一帧回调$d');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPaintPage'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              child: const Cake(),
            ),
            Expanded(
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: TestPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    final Paint paint = Paint();
    paint.color = Colors.red;
    canvas.drawCircle(const Offset(0, 0), 40, paint);
  }

  @override
  bool shouldRepaint(TestPainter oldDelegate) => oldDelegate != this;

  // @override
  // bool shouldRebuildSemantics(TestPainter oldDelegate) => false;
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
        boundingRect, radius, radius, true, getColoredPaint(Colors.black38));
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

// 将饼图包装成一个新的控件
class Cake extends StatelessWidget {
  const Cake({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: WheelPainter(),
    );
  }
}
