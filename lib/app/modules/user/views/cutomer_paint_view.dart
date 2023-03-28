// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// CustomPaint 是用以承接自绘控件的容器，并不负责真正的绘制

class CustomPaintPage extends StatefulWidget {
  const CustomPaintPage({Key? key}) : super(key: key);

  @override
  State<CustomPaintPage> createState() => _CustomPaintPageState();
}

class _CustomPaintPageState extends State<CustomPaintPage> {
  bool _isShowAll = false;
  final String _showText =
      '做这个demo思路来源于微信team的：微信iOS卡顿监控系统。主要思路:通过监测Runloop的kCFRunLoopAfterWaiting，用一个子线程去检查，一次循环是否时间太长。其中主要涉及到了runloop的原理。关于整个原理：深入理解RunLoop讲解的比较仔细。';
  final TextStyle _showTextStyle =
      const TextStyle(fontSize: 17.0, color: Colors.black);
  final int _showTextMaxLines = 3;

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
      TextPainter textP = getTextPainter(context, _showText, _showTextStyle,
          ScreenUtil().screenWidth, _showTextMaxLines);
      debugPrint(textP.size.toString());
      _isShowAll = textP.didExceedMaxLines;
      setState(() {});
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
            const Image(
              image: AssetImage('assets/images/alert.png'),
              width: 100,
              height: 100,
            ),
            if (_isShowAll)
              RichText(
                  text: TextSpan(
                      text: _showText,
                      style: _showTextStyle,
                      children: <TextSpan>[
                    TextSpan(
                        text: _isShowAll ? '隐藏' : '展开',
                        style:
                            const TextStyle(fontSize: 17.0, color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint('123');
                          })
                  ])),
            const Cake()
          ],
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
