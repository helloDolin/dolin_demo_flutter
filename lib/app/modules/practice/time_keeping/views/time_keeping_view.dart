import 'dart:math';

import 'package:dolin/app/modules/practice/time_keeping/controllers/time_keeping_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
1 圈 1 分钟，每秒对应 3 格，即有 180 格，每格夹角是 2°
Ticker 来根据手机刷新率不断触发事件
*/

class TimeKeepingView extends GetView<TimeKeepingController> {
  const TimeKeepingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TimeKeepingView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildStopWatchPannel(context),
          _buildRecordPanel(),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Expanded _buildRecordPanel() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        // color: Colors.green,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'IBMPlexMono',
            fontSize: 18,
          ),
          child: Obx(
            () => ListView.builder(
              itemBuilder: (context, index) {
                // 技术点：有序数列，首位插入效率低
                // 将索引做下翻转
                final int reverseIndex =
                    (controller.records.length - 1) - index;
                final bool isLightIndex =
                    reverseIndex == controller.records.length - 1;

                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      child: Text(
                        reverseIndex.toString().padLeft(2, '0'),
                        style: TextStyle(
                          color: isLightIndex ? Colors.green : Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      controller.durationToString(
                        controller.records[reverseIndex].record,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      child: Text(
                        '+${controller.durationToString(controller.records[reverseIndex].addition)}',
                      ),
                    ),
                  ],
                );
              },
              itemCount: controller.records.length,
            ),
          ),
        ),
      ),
    );
  }

  Obx _buildStopWatchPannel(BuildContext context) {
    // 半径：屏幕宽的一半 * 0.75
    final double radius = MediaQuery.of(context).size.shortestSide / 2 * 0.75;
    final double fontSize = radius / 3.2;

    return Obx(
      () => SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: CustomPaint(
          painter: StopwatchPainter(
            duration: controller.duration.value,
            radius: radius,
            textStyle: TextStyle(
              color: const Color(0xff343434),
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }

  Obx _buildBottomButton() {
    return Obx(
      () => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 50,
            children: [
              if (controller.timeKeepStatus.value != TimeKeepStatus.none)
                GestureDetector(
                  onTap: controller.onReset,
                  child: Icon(
                    color: controller.resetColor,
                    Icons.refresh,
                    size: 28,
                  ),
                ),
              FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: controller.onTaggle,
                child: controller.running
                    ? const Icon(Icons.pause, color: Colors.white)
                    : const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
              ),
              if (controller.timeKeepStatus.value != TimeKeepStatus.none)
                GestureDetector(
                  onTap: controller.onRecoder,
                  child: Icon(
                    Icons.flag_outlined,
                    color: controller.flagColor,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

const double _kScaleWidthRate = 0.04;
const _kStrokeWidthRate = 0.8 / 135.0;
const _kIndicatorRadiusRate = 0.03;

class StopwatchPainter extends CustomPainter {
  StopwatchPainter({
    required this.radius,
    required this.duration,
    this.secondDuration = Duration.zero,
    this.themeColor = Colors.green,
    this.scaleColor = const Color(0xffDADADA),
    this.textStyle = const TextStyle(
      color: Color(0xff343434),
    ),
  }) {
    indicatorPainter.color = themeColor;
    scalePainter
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kStrokeWidthRate * radius;
  }
  final Duration duration;
  final Duration secondDuration;
  final double radius;
  final Color themeColor;
  final Color scaleColor;
  final TextStyle textStyle;

  final Paint scalePainter = Paint();
  final Paint indicatorPainter = Paint();
  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2); // 设置中心点

    drawScale(canvas, size); // 画刻度
    drawLightLineAndBall(canvas, size); // 画高亮线和小球
    drawText(canvas); // 画文本
  }

  void drawLightLineAndBall(Canvas canvas, Size size) {
    canvas.save();
    final double scaleLineWidth = size.width * _kScaleWidthRate;
    final double indicatorRadius = size.width * _kIndicatorRadiusRate;

    final int second = duration.inSeconds % 60; // 秒
    final int milliseconds = duration.inMilliseconds % 1000; // 毫秒
    final double radians =
        (second * 1000 + milliseconds) / (60 * 1000) * 2 * pi; // 弧度
    canvas
      ..rotate(radians)
      ..drawCircle(
        Offset(
          0,
          -size.width / 2 + scaleLineWidth + indicatorRadius,
        ),
        indicatorRadius / 2,
        indicatorPainter,
      )
      ..restore();
  }

  void drawText(Canvas canvas) {
    final int minus = duration.inMinutes % 60;
    final int second = duration.inSeconds % 60;
    final int milliseconds = duration.inMilliseconds % 1000;
    final String commonStr =
        '${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
    final String highlightStr =
        ".${(milliseconds ~/ 10).toString().padLeft(2, "0")}";
    textPainter
      ..text = TextSpan(
        text: commonStr,
        style: textStyle,
        children: [
          TextSpan(
            text: highlightStr,
            style: textStyle.copyWith(color: themeColor),
          ),
        ],
      )
      ..layout(); // 进行布局
    final double width = textPainter.size.width;
    final double height = textPainter.size.height;
    textPainter.paint(canvas, Offset(-width / 2, -height / 2));
  }

  void drawScale(Canvas canvas, Size size) {
    canvas.save();
    final double scaleLineWidth = size.width * _kScaleWidthRate;

    for (int i = 0; i < 180; i++) {
      if (i == 90 + 45) {
        scalePainter.color = themeColor;
      } else {
        scalePainter.color = scaleColor;
      }
      canvas
        ..drawLine(
          Offset(size.width / 2, 0),
          Offset(size.width / 2 - scaleLineWidth, 0),
          scalePainter,
        )
        ..rotate(pi / 180 * 2);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant StopwatchPainter oldDelegate) {
    return oldDelegate.duration != duration ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.themeColor != themeColor ||
        oldDelegate.scaleColor != scaleColor;
  }
}
