import 'dart:math' as math;

import 'package:flutter/material.dart';

enum CornerMarkPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight;
}

// 右上角带有角标
class CornerMark extends StatelessWidget {
  const CornerMark({
    required this.child,
    required this.markTitle,
    required this.markTitleSize,
    required this.markBgColor,
    required this.markTitleColor,
    super.key,
    this.cornerMarkPosition = CornerMarkPosition.topRight,
  });

  final Widget child;
  final String markTitle;
  final double markTitleSize;
  final Color markBgColor;
  final Color markTitleColor;
  final CornerMarkPosition? cornerMarkPosition;

  @override
  Widget build(BuildContext context) {
    double? left;
    double? right;
    double? top;
    double? bottom;

    // , right, top, bottom = 0;
    Alignment transformAlignment = Alignment.center;
    double angle = 0;
    final textSpan = TextSpan(
      text: markTitle,
      style: TextStyle(fontSize: markTitleSize, color: markTitleColor),
    );
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
    final double w = textPainter.width * 2;

    final double h = textPainter.height;
    //double top = math.sqrt(
    // (w - math.sqrt(h * h + h * h)) * (w - math.sqrt(h * h + h * h)) / 2)
    // 公式简化
    final double offset = (w - math.sqrt(h * h + h * h)) / math.sqrt2;
    debugPrint('offset : $offset');

    switch (cornerMarkPosition) {
      case CornerMarkPosition.topLeft:
        transformAlignment = Alignment.bottomLeft;
        angle = -math.pi / 4;
        left = 0;
        right = null;
        top = offset;
        bottom = null;
      case CornerMarkPosition.topRight:
        transformAlignment = Alignment.bottomRight;
        angle = math.pi / 4;
        left = null;
        right = 0;
        top = offset;
        bottom = null;
      case CornerMarkPosition.bottomLeft:
        transformAlignment = Alignment.topLeft;
        angle = math.pi / 4;
        left = 0;
        right = null;
        top = null;
        bottom = offset;
      case CornerMarkPosition.bottomRight:
        transformAlignment = Alignment.topRight;
        angle = -math.pi / 4;
        left = null;
        right = 0;
        top = null;
        bottom = offset;
      // ignore: no_default_cases
      default:
        throw Exception('无此类型');
    }

    return ClipRect(
      // clipBehavior: Clip.none,
      child: Stack(
        children: [
          child,
          Positioned(
            left: left,
            right: right,
            top: top,
            bottom: bottom,
            child: Transform.rotate(
              alignment: transformAlignment, // 旋转中心点
              angle: angle,
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
