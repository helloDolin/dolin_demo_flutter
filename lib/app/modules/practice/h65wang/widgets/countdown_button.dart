import 'dart:ui';

import 'package:flutter/material.dart';

/// CountdownButton 状态
enum CountdownButtonStatus { send, cancel, done }

class CountdownButton extends StatefulWidget {
  const CountdownButton({
    super.key,
    required this.duration,
    required this.width,
    required this.height,
    required this.radius,
  });

  /// 时长
  final Duration duration;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 圆角值
  final double radius;

  @override
  State<CountdownButton> createState() => _CountdownButtonState();
}

class _CountdownButtonState extends State<CountdownButton>
    with SingleTickerProviderStateMixin {
  CountdownButtonStatus countdownButtonStatus = CountdownButtonStatus.send;

  late final AnimationController _ac = AnimationController(vsync: this)
    ..duration = widget.duration
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          countdownButtonStatus = CountdownButtonStatus.done;
        });
      }
    });

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String label = 'Send';
    Color textColor = Colors.white;
    Color bgColor = Colors.blue;
    switch (countdownButtonStatus) {
      case CountdownButtonStatus.send:
        label = 'Send';
        textColor = Colors.white;
        bgColor = Colors.blue;
        break;
      case CountdownButtonStatus.cancel:
        label = 'Cancel';
        textColor = Colors.blue;
        bgColor = Colors.white;
        break;
      case CountdownButtonStatus.done:
        label = 'Done';
        textColor = Colors.grey;
        bgColor = Colors.white;
        break;
      default:
    }

    return Stack(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: CustomPaint(
            painter: BorderPainter(
              widget.width,
              widget.height,
              widget.radius,
              _ac,
            ),
          ),
        ),
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextButton(
              onPressed: () {
                switch (countdownButtonStatus) {
                  case CountdownButtonStatus.send:
                    _ac.forward(from: 0.0);
                    setState(() {
                      countdownButtonStatus = CountdownButtonStatus.cancel;
                    });
                    break;
                  case CountdownButtonStatus.cancel:
                  case CountdownButtonStatus.done:
                    _ac.reset();
                    setState(() {
                      countdownButtonStatus = CountdownButtonStatus.send;
                    });
                    break;
                  default:
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: textColor,
                backgroundColor: bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
              ),
              child: Text(label)),
        )
      ],
    );
  }
}

class BorderPainter extends CustomPainter {
  final double btnWidth;
  final double btnHeight;
  final double btnRadius;
  final Animation<double> animation;

  final Paint bluePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = Colors.blue;

  final Paint greyPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..color = Colors.grey;

  // late Rect rect;
  late RRect shape;
  late PathMetric pathMetric;

  BorderPainter(this.btnWidth, this.btnHeight, this.btnRadius, this.animation)
      : super(repaint: animation) {
    shape = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: btnWidth, height: btnHeight),
      Radius.circular(btnRadius),
    );
    // final path = Path()..addRRect(shape);
    // // computeMetrics 把路径的行为特征计算出来
    // pathMetric = path.computeMetrics().single;
    // print('path pathMetric: $pathMetric');
    final Radius radius = Radius.circular(btnRadius);
    final path = Path()
      ..moveTo(btnWidth / 2, 0)
      ..relativeLineTo(btnWidth / 2 - btnRadius, 0)
      ..relativeArcToPoint(Offset(btnRadius, btnRadius), radius: radius)
      ..relativeLineTo(0, btnHeight - 2 * btnRadius)
      ..relativeArcToPoint(Offset(-btnRadius, btnRadius), radius: radius)
      ..relativeLineTo(-btnWidth + 2 * btnRadius, 0)
      ..relativeArcToPoint(Offset(-btnRadius, -btnRadius), radius: radius)
      ..relativeLineTo(0, -btnHeight + 2 * btnRadius)
      ..relativeArcToPoint(Offset(btnRadius, -btnRadius), radius: radius)
      ..close();
    pathMetric = path.computeMetrics().single;

    print('BorderPainter 构造函数');
  }

  @override
  void paint(Canvas canvas, Size size) {
    print('BorderPainter paint');
    final totalLength = pathMetric.length;
    final curLength = totalLength * animation.value;

    // extractPath：提取路径
    // path.addPath(pathMetric.extractPath(0, curLength), Offset.zero);

    // 第一种方案
    // final startingPoint = totalLength / 4 + max(btnHeight / 2 - btnRadius, 0);
    // path 分为两段，为了起点位置从 12 点开始
    // path.addPath(
    //     pathMetric.extractPath(startingPoint, curLength + startingPoint),
    //     Offset.zero);
    // path.addPath(
    //     pathMetric.extractPath(0.0, curLength - totalLength + startingPoint),
    //     Offset.zero);
    // canvas.translate(btnWidth / 2, btnHeight / 2);
    // canvas.drawRRect(shape, bluePaint);
    // canvas.drawPath(path, greyPaint);

    // 第二种方案
    canvas.save();
    canvas.translate(btnWidth / 2, btnHeight / 2);
    canvas.drawRRect(shape, bluePaint);
    canvas.restore();

    canvas.drawPath(pathMetric.extractPath(0, curLength), greyPaint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) =>
      btnRadius != oldDelegate.btnRadius &&
      btnWidth != oldDelegate.btnWidth &&
      btnHeight != oldDelegate.btnHeight;

  // @override
  // bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
