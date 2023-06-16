import 'dart:math' as math;

import 'package:flutter/material.dart';

// 右上角带有角标
class CornerMark extends StatelessWidget {
  const CornerMark({
    super.key,
    required this.child,
    required this.markTitle,
    required this.markTitleSize,
    required this.markBgColor,
    required this.markTitleColor,
  });

  final Widget child;
  final String markTitle;
  final double markTitleSize;
  final Color markBgColor;
  final Color markTitleColor;

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(
        text: markTitle,
        style: TextStyle(fontSize: markTitleSize, color: markTitleColor));
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
    double w = textPainter.width * 2;
    double h = textPainter.height;
    //double top = math.sqrt(
    // (w - math.sqrt(h * h + h * h)) * (w - math.sqrt(h * h + h * h)) / 2)
    // 公式简化
    double top = (w - math.sqrt(h * h + h * h)) / math.sqrt2;
    return ClipRect(
      child: Stack(
        children: [
          child,
          Positioned(
            right: 0,
            top: top,
            child: Transform.rotate(
              alignment: Alignment.bottomRight, // 旋转中心点
              angle: math.pi / 4,
              child: Container(
                alignment: Alignment.center,
                width: w,
                height: h,
                color: markBgColor,
                child: Text.rich(textSpan),
              ),
            ),
          )
        ],
      ),
    );
  }
}
